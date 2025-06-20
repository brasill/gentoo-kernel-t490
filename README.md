
# 🚀 Kernel Gentoo Otimizado para ThinkPad T490 com GNOME + OpenRC

Este repositório documenta o processo completo de compilação e otimização do kernel Linux para rodar Gentoo com GNOME e OpenRC no ThinkPad T490.

## 🎯 Objetivo

- Aprimorar a compreensão sobre configuração de kernels.
- Garantir máxima compatibilidade e performance no T490.
- Documentar para replicar, melhorar e compartilhar.

## 🖥️ Hardware

| Componente     | Detalhes                                 |
|----------------|------------------------------------------|
| CPU            | Intel i5-8365U (Whiskey Lake)           |
| GPU            | Intel UHD Graphics 620                  |
| Armazenamento  | SSD NVMe Kingston NV3                   |
| Rede           | Intel I219-LM (Ethernet) + CNVi (Wi-Fi) |
| Áudio          | Intel Cannon Point-LP (SOF)             |
| Outros         | Bluetooth, Webcam, Leitor SD, Thunderbolt |

## 🗺️ Documentação

- 📄 [hardware_t490.txt](docs/hardware_t490.txt) - Mapeamento do hardware
- ✅ [Checklist menuconfig](docs/checklist_menuconfig.md) - Guia passo a passo para configuração manual

## 🚀 Processo de Compilação

### 🔧 Pré-requisitos

```bash
emerge -av sys-apps/pciutils sys-apps/usbutils sys-kernel/genkernel sys-fs/dosfstools
```

### 📜 Exportando configuração atual

```bash
cd /usr/src/linux
zcat /proc/config.gz > .config
```

### ⚙️ Compilando o kernel com menuconfig

```bash
genkernel --menuconfig --clean --install all
```

### 🔄 Atualizando GRUB

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

### 🔥 Reinicie e selecione o novo kernel no GRUB.

## ✅ Checklist das Configurações Críticas

- ✔️ Processador (Intel Core-family, Intel P-State, microcode)
- ✔️ NVMe (CONFIG_BLK_DEV_NVME)
- ✔️ USB (xHCI)
- ✔️ Gráficos (i915)
- ✔️ Rede Ethernet (e1000e)
- ✔️ Wi-Fi (iwlwifi + iwlmvm)
- ✔️ Áudio (snd_hda_intel + SOF)
- ✔️ ThinkPad ACPI
- ✔️ Bluetooth (btintel)
- ✔️ Webcam (UVC)
- ✔️ Leitor SD (rtsx_pci)
- ✔️ Thunderbolt

## 📜 Licença

Distribuído sob a licença MIT. Consulte [LICENSE](LICENSE) para mais informações.

## 🙌 Autor

Samuel Alves Pereira — [GitHub](https://github.com/seuusuario)
