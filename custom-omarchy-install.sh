#!/bin/bash

echo -e "\e[1;32;4;40m=== Installing missing apps/tools ===\e\e[0m"

# Install stow
if ! command -v stow &>/dev/null; then
    yay -S --noconfirm --needed stow
    echo -e "\e[1;32;4;40m=== Installed stow ===\e[0m"
fi

# Install fish shell
if ! command -v fish &>/dev/null; then
    yay -S --noconfirm --needed fish
    echo -e "\e[1;32;4;40m=== Installed fish ===\e[0m"
fi

# Install wezterm,
# prefer nightly binary because building it takes FOREVER
if ! command -v wezterm &>/dev/null; then
    yay -S --noconfirm --needed wezterm-nightly-bin
    echo -e "\e[1;32;4;40m=== Installed wezterm-nightly-bin ===\e[0m"
fi

# Install lsd
if ! command -v lsd &>/dev/null; then
    yay -S --noconfirm --needed lsd
    echo -e "\e[1;32;4;40m=== Installed lsd ===\e[0m"
fi

# Install yazi
if ! command -v yazi &>/dev/null; then
    yay -S --noconfirm --needed yazi
    echo -e "\e[1;32;4;40m=== Installed yazi ===\e[0m"
fi

# Install atuin
if ! command -v atuin &>/dev/null; then
    yay -S --noconfirm --needed atuin
    echo -e "\e[1;32;4;40m=== Installed atuin ===\e[0m"
fi

# Install fx
if ! command -v fx &>/dev/null; then
    yay -S --noconfirm --needed fx
    echo -e "\e[1;32;4;40m=== Installed fx ===\e[0m"
fi

# Install ov
if ! command -v ov &>/dev/null; then
    yay -S --noconfirm --needed ov
    echo -e "\e[1;32;4;40m=== Installed ov ===\e[0m"
fi

# Install 7zip
if ! command -v 7z &>/dev/null; then
    yay -S --noconfirm --needed 7zip
    echo -e "\e[1;32;4;40m=== Installed 7zip ===\e[0m"
fi

# Install diff-so-fancy
if ! command -v diff-so-fancy &>/dev/null; then
    yay -S --noconfirm --needed diff-so-fancy
    echo -e "\e[1;32;4;40m=== Installed diff-so-fancy ===\e[0m"
fi

# Install bibata cursor theme
# Use binary
if ! yay -Q "bibata-cursor-theme-bin" >/dev/null 2>&1; then
    yay -S --noconfirm --needed bibata-cursor-theme-bin
    echo -e "\e[1;32;4;40m=== Installed bibata-cursor-theme-bin ===\e[0m"
fi

# Install Helium browser
# Use binary
if ! yay -Q "helium-browser-bin" >/dev/null 2>&1; then
    yay -S --noconfirm --needed helium-browser-bin
    echo -e "\e[1;32;4;40m=== Installed helium-browser-bin ===\e[0m"
fi

# Install Vesktop (Discord app)
# Use binary
if ! yay -Q "vesktop-bin" >/dev/null 2>&1; then
    yay -S --noconfirm --needed vesktop-bin
    echo -e "\e[1;32;4;40m=== Installed vesktop-bin ===\e[0m"
fi

# Install Steam
# Use Omarchy script
if ! yay -Q "steam" >/dev/null 2>&1; then
    omarchy-install-steam
    echo -e "\e[1;32;4;40m=== Installed steam ===\e[0m"
fi

if ! bat --list-themes | grep tokyonight &>/dev/null; then
    # https://github.com/folke/tokyonight.nvim/issues/23#issuecomment-1581586548
    mkdir -p "$(bat --config-dir)/themes"
    cd "$(bat --config-dir)/themes"
    # Replace _night in the lines below with _day, _moon, or _storm if needed.
    curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
    bat cache --build
    # bat --list-themes | grep tokyo # should output "tokyonight_night"
    # echo '--theme="tokyonight_night"' >> "$(bat --config-dir)/config"
    echo -e "\e[1;32;4;40m=== Added tokyonight bat theme ===\e[0m"
fi

echo -e "\e[1;32;4;40m=== Done! ===\e[0m"
