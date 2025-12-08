#!/bin/bash

# Install stow
if ! command -v stow &>/dev/null; then
    yay -S --noconfirm --needed stow
    echo "Installed stow"
fi

# Install fish shell
if ! command -v fish &>/dev/null; then
    yay -S --noconfirm --needed fish
    echo "Installed fish"
fi

# Install wezterm,
# prefer nightly binary because building it takes FOREVER
if ! command -v wezterm &>/dev/null; then
    yay -S --noconfirm --needed wezterm-nightly-bin
    echo "Installed wezterm-nightly-bin"
fi

# Install lsd
if ! command -v lsd &>/dev/null; then
    yay -S --noconfirm --needed lsd
    echo "Installed lsd"
fi

# Install yazi
if ! command -v yazi &>/dev/null; then
    yay -S --noconfirm --needed yazi
    echo "Installed yazi"
fi

# Install atuin
if ! command -v atuin &>/dev/null; then
    yay -S --noconfirm --needed atuin
    echo "Installed atuin"
fi

# Install fx
if ! command -v fx &>/dev/null; then
    yay -S --noconfirm --needed fx
    echo "Installed fx"
fi

# Install ov
if ! command -v ov &>/dev/null; then
    yay -S --noconfirm --needed ov
    echo "Installed ov"
fi

# Install diff-so-fancy
if ! command -v diff-so-fancy &>/dev/null; then
    yay -S --noconfirm --needed diff-so-fancy
    echo "Installed diff-so-fancy"
fi

# Install bibata cursor theme
# Use binary
if ! yay -Q "bibata-cursor-theme-bin" >/dev/null 2>&1; then
    yay -S --noconfirm --needed bibata-cursor-theme-bin
    echo "Installed bibata-cursor-theme-bin"
fi

# Install Helium browser
# Use binary
if ! yay -Q "helium-browser-bin" >/dev/null 2>&1; then
    yay -S --noconfirm --needed helium-browser-bin
    echo "Installed helium-browser-bin"
fi

# Install Vesktop (Discord app)
# Use binary
if ! yay -Q "vesktop-bin" >/dev/null 2>&1; then
    yay -S --noconfirm --needed vesktop-bin
    echo "Installed vesktop-bin"
fi

# Install Steam
# Use Omarchy script
if ! yay -Q "steam" >/dev/null 2>&1; then
    omarchy-install-steam
    echo "Installed steam"
fi

