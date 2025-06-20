
# 🧠 Checklist menuconfig - Kernel para ThinkPad T490

## 🔥 Seções Críticas

- Processor type and features
  - [x] Intel Core-family
  - [x] Intel microcode loading
  - [x] Intel P-State driver

- NVMe Support
  - [x] NVMe block device (*)

- USB Support
  - [x] xHCI HCD (*)

## 🎨 Graphics
- [x] Intel 8xx/9xx/G3x/G4x/HD Graphics (i915) (M)
- [x] Enable firmware loading in drivers

## 🌐 Network
- Ethernet
  - [x] Intel PRO/1000 (e1000e) (M)
- Wireless LAN
  - [x] Intel Wireless WiFi (iwlwifi) (M)
  - [x] Intel Wireless MVM firmware (iwlmvm) (M)

## 🔊 Sound
- [x] HD Audio PCI (snd_hda_intel) (M)
- [x] SOF for Cannon Lake (snd_soc_sof_intel_cnl) (M)

## 🔋 Power Management
- [x] CPU Frequency scaling (Intel P-State)

## 🔧 Periféricos
- [x] ThinkPad ACPI
- [x] Realtek PCI-E Card Reader (rtsx_pci) (M)
- [x] Thunderbolt support (M)
- [x] USB Video Class (Webcam) (M)
- [x] Synaptics Fingerprint Reader (M)
