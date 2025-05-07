#!/bin/bash

# Define alias block
alias_block=$(cat << 'EOF'

# >>> Arch Linux Aliases >>>
alias update='sudo pacman -Syu'
alias upgrade='sudo pacman -Syyu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias info='pacman -Qi'
alias files='pacman -Ql'
alias owns='pacman -Qo'
alias cleanup='sudo pacman -Rns $(pacman -Qdtq)'
alias mirror-update='sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias paru='paru'
alias pa='paru -Syu --noconfirm'
alias aursearch='paru -Ss'
alias aurinfo='paru -Qi'
alias aurinstall='paru -S'
alias paclog='cat /var/log/pacman.log | less'
# <<< Arch Linux Aliases <<<
EOF
)

# File to modify
zshrc_file="$HOME/.zshrc"

# Check if the aliases already exist
if grep -q ">>> Arch Linux Aliases >>>" "$zshrc_file"; then
    echo "Arch Linux aliases already exist in $zshrc_file"
else
    echo "$alias_block" >> "$zshrc_file"
    echo "Arch Linux aliases added to $zshrc_file"
fi

# Optional: reload .zshrc automatically
# Uncomment the following line if you want to apply changes immediately
# source "$zshrc_file"
