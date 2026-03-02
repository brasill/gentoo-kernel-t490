#!/bin/bash
# scripts/diag-kernel.sh
# Diagnóstico automático de configuração do kernel
#
# Uso: execute dentro do diretório de source do kernel que deseja auditar
#   cd /usr/src/linux-6.12.58-gentoo-devops
#   bash /caminho/para/repo/scripts/diag-kernel.sh
#
# Ou com caminho absoluto direto:
#   bash scripts/diag-kernel.sh (a partir da raiz do repositório clonado)

CONFIG_FILE=".config"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "[ERRO] Arquivo .config não encontrado no diretório atual."
    echo "Execute este script dentro de um diretório de source do kernel."
    exit 1
fi

echo "==== BOOT ===="
grep -E "CONFIG_BLK_DEV_NVME=|CONFIG_AHCI=|CONFIG_SATA_AHCI=|CONFIG_EFI_STUB=|CONFIG_USB_XHCI_HCD=|CONFIG_EXT4_FS=|CONFIG_VFAT_FS=" "$CONFIG_FILE"
echo

echo "==== INITRAMFS ===="
grep -E "CONFIG_BLK_DEV_INITRD=|CONFIG_INITRAMFS_COMPRESSION_GZIP=" "$CONFIG_FILE"
echo

echo "==== CPU/ACPI ===="
grep -E "CONFIG_INTEL_PSTATE=|CONFIG_X86_INTEL_LPSS=|CONFIG_THINKPAD_ACPI=|CONFIG_MICROCODE=|CONFIG_MICROCODE_INTEL=" "$CONFIG_FILE"
echo

echo "==== VIRTUALIZAÇÃO ===="
grep -E "CONFIG_KVM=|CONFIG_KVM_INTEL=|CONFIG_VIRTIO_|CONFIG_VHOST_|CONFIG_VFIO=|CONFIG_IOMMU_SUPPORT=|CONFIG_INTEL_IOMMU=" "$CONFIG_FILE"
echo

echo "==== CONTAINERS ===="
grep -E "CONFIG_NAMESPACES=|CONFIG_CGROUPS=|CONFIG_MEMCG=|CONFIG_OVERLAY_FS=|CONFIG_NET_NS=|CONFIG_USER_NS=|CONFIG_PID_NS=" "$CONFIG_FILE"
echo

echo "==== SEGURANÇA ===="
grep -E "CONFIG_STACKPROTECTOR_STRONG=|CONFIG_SLAB_FREELIST_HARDENED=|CONFIG_STRICT_KERNEL_RWX=|CONFIG_STRICT_MODULE_RWX=|CONFIG_FORTIFY_SOURCE=" "$CONFIG_FILE"
echo

echo "==== REDE ===="
grep -E "CONFIG_IWLWIFI|CONFIG_IWLMVM|CONFIG_MAC80211|CONFIG_CFG80211|CONFIG_BRIDGE=|CONFIG_TUN=|CONFIG_VLAN_8021Q=|CONFIG_VXLAN=|CONFIG_NF_TABLES=|CONFIG_IP_NF_IPTABLES=|CONFIG_IP_NF_NAT=" "$CONFIG_FILE"
echo

echo "==== THINKPAD T490 ===="
grep -E "CONFIG_THINKPAD_ACPI=|CONFIG_SND_HDA_INTEL=|CONFIG_USB_VIDEO_CLASS=|CONFIG_VIDEO_UVC=|CONFIG_BT_INTEL=|CONFIG_BT_HCIBTUSB=" "$CONFIG_FILE"
echo

echo "==== PASSTHROUGH ===="
grep -E "CONFIG_VFIO=|CONFIG_VFIO_PCI=|CONFIG_VFIO_VIRQFD=|CONFIG_VFIO_MDEV=|CONFIG_VFIO_IOMMU_TYPE1=|CONFIG_USB_SERIAL_CP210X=" "$CONFIG_FILE"
echo

echo "[✔] Diagnóstico concluído."
