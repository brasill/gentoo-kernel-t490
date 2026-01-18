# 🚀 Kernel Gentoo Otimizado para ThinkPad T490 (Hardened / Minimal)

Este repositório documenta a **compilação, otimização e hardening** do kernel Linux (Gentoo Sources)
especificamente para o **Lenovo ThinkPad T490**.

O objetivo é manter **documentação clara, linear e profissional**, evitando subdiretórios desnecessários
e priorizando **facilidade de leitura**, no mesmo estilo do repositório
[evolution-gnome-gentoo](https://github.com/brasill/evolution-gnome-gentoo).

---

## 🎯 Objetivo

- Domínio da arquitetura do Kernel Linux
- Redução de tempo de boot e latência
- Kernel monolítico Intel-only
- Redução de superfície de ataque

---

## 🧠 Estratégia de Otimização

### Bootstrap com Genkernel
Garantia de boot funcional inicial.

### Refinamento com localmodconfig
Remoção agressiva de drivers não utilizados.

- Remoção do haveged
- Uso do Intel RDRAND

---

## 🖥️ Hardware Alvo

Intel i5-8365U • UHD 620 • NVMe • I219-LM • CNVi • TPM 2.0

---

## 🔧 Workflow de Compilação

```bash
emerge -av sys-kernel/gentoo-sources genkernel pciutils usbutils
```

```bash
cd /usr/src/linux
cp .config ~/backup-kernel-$(date +%F).config
make menuconfig
make -j$(nproc) && make modules_install && make install
grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 📜 Licença

MIT License

⚠️ Configurações específicas ao ThinkPad T490.
