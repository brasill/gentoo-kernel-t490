#!/bin/bash
echo "🔧 Copiando configuração atual..."
cd /usr/src/linux || exit
zcat /proc/config.gz > .config

echo "🚀 Iniciando compilação do kernel com menuconfig..."
genkernel --menuconfig --clean --install all

echo "🔄 Atualizando GRUB..."
grub-mkconfig -o /boot/grub/grub.cfg

echo "✅ Kernel compilado e instalado com sucesso!"
