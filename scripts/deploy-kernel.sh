#!/bin/bash
# scripts/deploy-kernel.sh
# Automação de deploy para a arquitetura segregada do /boot
# Instalação: cp scripts/deploy-kernel.sh /usr/local/sbin/deploy-kernel && chmod +x /usr/local/sbin/deploy-kernel

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${GREEN}Iniciando deploy customizado do Kernel...${NC}"

if [ ! -d "/usr/src/linux" ]; then
    echo -e "${RED}ERRO: Link /usr/src/linux não encontrado!${NC}"
    exit 1
fi

KV=$(make -C /usr/src/linux -s kernelrelease)
echo -e "Versão detectada: ${YELLOW}${KV}${NC}"

BZIMAGE="/usr/src/linux/arch/x86/boot/bzImage"
if [ ! -f "$BZIMAGE" ]; then
    echo -e "${RED}ERRO: bzImage não encontrada. Você rodou 'make' primeiro?${NC}"
    exit 1
fi

echo "Copiando Kernel para /boot/kernels/${KV}..."
cp "$BZIMAGE" "/boot/kernels/${KV}"

echo "Gerando Initramfs com Dracut em /boot/initramfs/${KV}.img..."
dracut --force "/boot/initramfs/${KV}.img" "${KV}"

echo -e "${GREEN}Deploy de arquivos concluído!${NC}"
echo "Verificando consistência no GRUB..."

if grep -q "${KV}" /etc/grub.d/40_custom; then
    echo -e "${GREEN}Tudo certo! A versão ${KV} já está mapeada no /etc/grub.d/40_custom.${NC}"
else
    echo -e "${YELLOW}======================================================================${NC}"
    echo -e "${YELLOW}AVISO IMPORTANTE: Versão nova de kernel detectada!${NC}"
    echo -e "O kernel ${KV} foi instalado nas pastas corretas, mas o seu"
    echo -e "arquivo /etc/grub.d/40_custom parece não ter entradas para ele."
    echo -e "Ação necessária:"
    echo -e "1. Edite: nano /etc/grub.d/40_custom"
    echo -e "2. Atualize a versão para: ${KV}"
    echo -e "3. Regere o GRUB: grub-mkconfig -o /boot/grub/grub.cfg"
    echo -e "${YELLOW}======================================================================${NC}"
fi
