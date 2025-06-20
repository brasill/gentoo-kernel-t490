# 🚀 Kernel Gentoo Otimizado para ThinkPad T490 com GNOME + OpenRC

Este repositório documenta o processo completo de compilação e otimização do kernel Linux para rodar Gentoo com GNOME e OpenRC no ThinkPad T490.

---

## 🎯 Objetivo

- Aprimorar a compreensão sobre configuração e compilação de kernels.
- Garantir máxima compatibilidade, desempenho e estabilidade no ThinkPad T490.
- Documentar o processo para replicação, aprendizado e compartilhamento.

---

## 🖥️ Hardware

| Componente     | Detalhes                                 |
|----------------|------------------------------------------|
| CPU            | Intel i5-8365U (Whiskey Lake)           |
| GPU            | Intel UHD Graphics 620                  |
| Armazenamento  | SSD NVMe Kingston NV3                   |
| Rede           | Intel I219-LM (Ethernet) + CNVi (Wi-Fi) |
| Áudio          | Intel Cannon Point-LP (SOF)             |
| Outros         | Bluetooth, Webcam, Leitor SD, Thunderbolt |

---

## 🗺️ Documentação

- 📄 [`docs/hardware_t490.txt`](docs/hardware_t490.txt) — Mapeamento do hardware (lspci, lsusb, cpuinfo)
- ✅ [`docs/checklist_menuconfig.md`](docs/checklist_menuconfig.md) — Guia passo a passo para configuração manual do kernel

---

## 🚀 Processo de Compilação

### 🔧 Pré-requisitos

Instale as ferramentas necessárias:

```bash
emerge -av sys-apps/pciutils sys-apps/usbutils sys-kernel/genkernel sys-fs/dosfstools


# 🗂️ Backup e Preparação da Compilação do Kernel no Gentoo

Este documento descreve como realizar o backup da configuração atual do kernel e preparar corretamente o ambiente antes da compilação no Gentoo.

---

## 📍 Local Correto para Executar os Comandos

Todos os comandos de compilação, configuração (`menuconfig`) e uso do `genkernel` devem ser executados **dentro do diretório `/usr/src/linux`**, que é um link simbólico apontando para a versão ativa do kernel.

### Verifique se o link está correto:

```bash
ls -l /usr/src/linux
eselect kernel list
eselect kernel set <número-da-versão>

### Realize o Backup

```bash
cp .config ~/backup-config-kernel-$(date +%F).config

✔️ O backup será salvo na sua home com a data no nome, exemplo:
backup-config-kernel-2025-06-20.config

---

# 🔄 Copiando a Configuração do Kernel em Execução (opcional)

Se desejar utilizar a configuração atual do kernel em execução como base:

```bash
zcat /proc/config.gz > .config

---

# ⚙️ Executando o Genkernel com Menuconfig

Execute o comando abaixo para abrir o menu de configuração interativo e, em seguida, compilar o kernel e o initramfs:

```bash
genkernel --menuconfig --clean --install all

# 🔧 Descrição dos parâmetros:
--menuconfig: Abre a interface gráfica do menu para configuração manual.

--clean: Limpa arquivos de compilações anteriores.

--install: Instala automaticamente o kernel e o initramfs na partição /boot.

all: Realiza a compilação tanto do kernel quanto do initramfs.

---

# 🖥️ Usando o Menuconfig
Durante o menu de configuração:

Navegue com as setas do teclado.

Use a barra de espaço para selecionar:

[ * ] → Compilar embutido no kernel.

[ M ] → Compilar como módulo.

Utilize a tecla / para buscar opções.

✔️ Consulte o arquivo docs/hardware_t490.txt para conferir quais drivers e funcionalidades você deve ativar de acordo com seu hardware.

---

# 🔄 Atualizando o Bootloader (GRUB)
Após a compilação bem-sucedida, atualize seu GRUB para reconhecer o novo kernel:

```bash
grub-mkconfig -o /boot/grub/grub.cfg

---

# 🔥 Finalização
✅ Reinicie seu computador. No menu do GRUB, selecione o novo kernel compilado.

✔️ Recomendação: Sempre mantenha ao menos uma versão anterior do kernel funcional no GRUB como fallback.

---

# ⚠️ Observação
Este procedimento é focado no aprendizado e no controle manual do processo de compilação do kernel. Recomenda-se não confiar exclusivamente em scripts, especialmente durante a fase de aprendizado.



