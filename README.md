# 🚀 Kernel Gentoo Otimizado para ThinkPad T490 (Hardened / Minimal)

Este repositório documenta a jornada de **compilação, otimização e hardening** do kernel Linux
(**Gentoo Sources**) especificamente para o **Lenovo ThinkPad T490**.

O foco é transicionar de um kernel genérico para uma **build monolítica, enxuta e Intel-only**,
utilizando recursos nativos do processador e removendo superfícies de ataque desnecessárias.
Toda a abordagem mantém **documentação clara, linear e profissional**, sem estruturas artificiais
ou subdiretórios desnecessários.

---

## 🎯 Objetivo

- **Domínio Técnico:** Aprofundar o conhecimento na arquitetura e nos subsistemas do Kernel Linux  
- **Performance:** Reduzir tempo de boot e latência utilizando instruções nativas de hardware  
- **Estabilidade:** Garantir compatibilidade total com o hardware do ThinkPad T490  
- **Hardening:** Redução agressiva da superfície de ataque  
- **Design:** Kernel **monolítico**, focado exclusivamente em hardware Intel  

---

## 🧠 Estratégia de Otimização (Roadmap)

A manutenção deste kernel segue uma lógica evolutiva de limpeza, especialização e endurecimento.

### 1. Bootstrap com Genkernel

O ponto de partida utiliza o `genkernel` para garantir um ambiente de boot funcional.

- Criação de um kernel genérico inicial
- Garantia de inicialização estável do sistema
- Inclusão ampla de drivers e subsistemas

**Limitação:**  
Para garantir compatibilidade universal, o `genkernel` habilita drivers e arquiteturas que não
existem no hardware alvo (ex.: CPUs AMD, drivers legacy, filesystems exóticos), resultando em
*bloat*, maior tempo de compilação e aumento da superfície de ataque.

---

### 2. Refinamento com `localmodconfig`

A segunda etapa aplica uma limpeza profunda utilizando `make localmodconfig`.

- O sistema em execução é analisado
- Apenas módulos realmente utilizados permanecem habilitados
- Tudo o que não corresponde ao hardware do T490 é removido

**Resultado direto:**

- Kernel **Intel-only**
- Remoção de subsistemas desnecessários
- Transição para um kernel **monolítico**
- Redução significativa da superfície de ataque

**Hardening adicional:**

- Remoção do daemon `haveged`
- Uso do **Intel Secure Key (RDRAND)** como fonte primária de entropia
- Entropia instantânea via hardware durante o boot

---

## 🖥️ Hardware Alvo

| Componente     | Detalhes                                   |
|----------------|--------------------------------------------|
| CPU            | Intel i5-8365U (Whiskey Lake)               |
| GPU            | Intel UHD Graphics 620                      |
| Armazenamento  | SSD NVMe Kingston NV3                       |
| Rede           | Intel I219-LM (Ethernet) + Intel CNVi (Wi-Fi) |
| Áudio          | Intel Cannon Point-LP (SOF)                 |
| Segurança      | TPM 2.0 / Intel RNG (DRNG)                  |

---

## 🗺️ Documentação Auxiliar

- 📄 `docs/hardware_t490.txt` — Dump completo de hardware (lspci, lsusb, cpuinfo)  
- ✅ `docs/checklist_menuconfig.md` — Checklist das opções críticas ajustadas manualmente  

---

## 🔧 Workflow de Compilação

### Pré-requisitos

Ferramentas essenciais para a construção e inspeção de hardware:

```bash
emerge -av sys-kernel/gentoo-sources            sys-kernel/genkernel            sys-apps/pciutils            sys-apps/usbutils            sys-fs/dosfstools
```

---

### Compilação do Kernel

```bash
cd /usr/src/linux
cp .config ~/backup-kernel-$(date +%F).config

make menuconfig
make -j$(nproc)
make modules_install
make install
```

---

### Atualização do Bootloader

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 📜 Licença

MIT License

---

⚠️ **Aviso:**  
Configurações altamente específicas para o **Lenovo ThinkPad T490**.  
Não recomendado para uso genérico sem revisão criteriosa.
