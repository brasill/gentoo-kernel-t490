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

