#!/bin/bash
# scripts/backup-cloud.sh
# Backup bare-metal do sistema Gentoo direto para o Google Drive via rclone
#
# Instalação:
#   cp scripts/backup-cloud.sh /usr/local/sbin/backup-cloud
#   chmod +x /usr/local/sbin/backup-cloud
#
# Pré-requisitos:
#   - rclone configurado com remote "gdrive" apontando para o Google Drive
#     (configuração em /home/$USER/.config/rclone/rclone.conf)
#   - /etc/backup-exclude.list criado (ver README)
#   - zstd instalado: emerge app-arch/zstd
#   - Executar como root
#
# Uso:
#   backup-cloud

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${GREEN}Iniciando backup completo do sistema (Bare-metal)...${NC}"

# Verifica execução como root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}ERRO: Este script precisa ser executado como root.${NC}"
    exit 1
fi

# Verifica lista de exclusão
if [ ! -f "/etc/backup-exclude.list" ]; then
    echo -e "${RED}ERRO: Arquivo /etc/backup-exclude.list não encontrado!${NC}"
    echo -e "Crie o arquivo com os diretórios a excluir antes de continuar."
    exit 1
fi

# Verifica se rclone está disponível
if ! command -v rclone &>/dev/null; then
    echo -e "${RED}ERRO: rclone não encontrado. Instale com: emerge net-misc/rclone${NC}"
    exit 1
fi

# Verifica se zstd está disponível
if ! command -v zstd &>/dev/null; then
    echo -e "${RED}ERRO: zstd não encontrado. Instale com: emerge app-arch/zstd${NC}"
    exit 1
fi

# Define nome do arquivo com timestamp
FILENAME="gentoo-backup-$(date +%F_%H-%M).tar.zst"
REMOTE_PATH="gdrive:Gentoo/Gentoo-NVME-500GB/${FILENAME}"
RCLONE_CONF="/home/${SUDO_USER:-$USER}/.config/rclone/rclone.conf"

echo -e "Destino:     ${YELLOW}${REMOTE_PATH}${NC}"
echo -e "Compactação: ${YELLOW}ZSTD (Multithread nível 8)${NC}"
echo -e "Config rclone: ${YELLOW}${RCLONE_CONF}${NC}"
echo -e ""
echo -e "Pressione [ENTER] para iniciar ou [CTRL+C] para cancelar..."
read -r

echo -e "${GREEN}Empacotando, compactando e enviando para o Google Drive...${NC}"

# Pipeline: TAR → ZSTD → RCLONE
# --numeric-owner  : preserva UIDs/GIDs numéricos (essencial para restauração)
# --xattrs / --acls: preserva atributos estendidos e ACLs
# zstd -T0 -8      : todos os threads disponíveis, nível 8 de compressão
# rclone rcat -P   : recebe stdin e envia ao destino com progresso
tar --exclude-from=/etc/backup-exclude.list \
    --numeric-owner --xattrs --acls -cpf - / \
    | zstd -T0 -8 \
    | rclone --config="${RCLONE_CONF}" rcat -P "${REMOTE_PATH}"

# PIPESTATUS[2] = código de saída do rclone (terceiro processo do pipe)
if [ "${PIPESTATUS[2]}" -eq 0 ]; then
    echo -e "${GREEN}Backup concluído e enviado com sucesso!${NC}"
    echo -e "Arquivo: ${YELLOW}${REMOTE_PATH}${NC}"
else
    echo -e "${RED}Ocorreu um erro durante o upload pelo rclone.${NC}"
    echo -e "Verifique a conectividade e a configuração do rclone."
    exit 1
fi
