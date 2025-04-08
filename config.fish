if status is-interactive
    # Commands to run in interactive sessions can go here
end


# =========================================
# 00-INITIALIZATION
# =========================================

set fish_greeting

# Currently disabling starship to try out tide
starship init fish | source

# -----------------------------------------
# Exports
# -----------------------------------------
export EDITOR=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/usr/lib/ccache/bin/:$PATH"

#export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
#export PATH="$JAVA_HOME/bin/:$PATH"


## =========================================
## 10-ALIASES
## =========================================

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias c='clear'

alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'

alias l='eza -a --icons'
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

alias shutdown='systemctl poweroff'

# Timeshift (make backup snapshot)
alias ts='~/.config/ml4w/scripts/snapshot.sh'
# Cleanup unused package, cache, and repo (pacman)
alias cleanup='~/.config/ml4w/scripts/cleanup.sh'

alias wifi='nmtui'

# NVIMF (Nvim with FZF)
alias nvimf='$EDITOR $(fzf --preview="bat --color=always {}")'
alias vf='$EDITOR $(fzf --preview="bat --color=always {}")'
alias vimf='$EDITOR $(fzf --preview="bat --color=always {}")'
alias v='$EDITOR'
alias vim='$EDITOR'
alias nvim-config='nvim ~/.config/nvim'
alias vc='nvim-config'

# Wezterm Terminal from flatpak
# alias wezterm='flatpak run org.wezfurlong.wezterm'

# -----------------------------------------------------
# ML4W Apps
# -----------------------------------------------------
alias ml4w='~/.config/ml4w/apps/ML4W_Welcome-x86_64.AppImage'
alias ml4w-settings='~/.config/ml4w/apps/ML4W_Dotfiles_Settings-x86_64.AppImage'
alias ml4w-sidebar='ags -t sidebar'
alias ml4w-hyprland='~/.config/ml4w/apps/ML4W_Hyprland_Settings-x86_64.AppImage'
alias ml4w-diagnosis='~/.config/hypr/scripts/diagnosis.sh'
alias ml4w-hyprland-diagnosis='~/.config/hypr/scripts/diagnosis.sh'
alias ml4w-qtile-diagnosis='~/.config/ml4w/qtile/scripts/diagnosis.sh'
alias ml4w-update='~/.config/ml4w/update.sh'

# -----------------------------------------------------
# Git
# -----------------------------------------------------
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# -----------------------------------------------------
# Scripts
# -----------------------------------------------------
alias ascii='~/.config/ml4w/scripts/figlet.sh'
alias freetar='~/scripts/start_freetar.sh'

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

## -----------------------------------------------------
## 20-CUSTOMIZATION
## -----------------------------------------------------

# PIPX Completions
# eval "$(register-python-argcomplete pipx)"

# Zoxide
eval "$(zoxide init --cmd cd fish)"

# Pywal
# cat ~/.cache/wal/sequences # Disabling pywal for wallust

# Wallust
# cat ~/.cache/wallust/sequences # Disabling wallust for catppuccin mocha in foot.ini

# NVM
# export NVM_DIR="$HOME/.nvm"
# if test -s "$NVM_DIR/nvm.sh"
#     source "$NVM_DIR/nvm.sh"
# end

# USE NODE VERSION NODE FROM NVM
nvm use node --silent

# PNPM
export PNPM_HOME="/home/movaa/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# THEME
# fish_config theme save "Catppuccin Mocha"

## -----------------------------------------
## 30-AUTOSTART
## ---------i--------------------------------

# -----------------------------------------------------
# Fastfetch
# -----------------------------------------------------
if string match -q "*pts*" (tty)
    fastfetch --config examples/13
else
    echo
    if test -f /bin/qtile
        echo "Start Qtile X11 with command Qtile"
    end
    if test -f /bin/hyprctl
        echo "Start Hyprland with command Hyprland"
    end
end

# Created by `pipx` on 2024-08-19 17:46:14
set PATH $PATH /home/movaa/.local/bin

## -----------------------------------------
## 40-PROMPT
## -----------------------------------------

fish_add_path /home/movaa/.spicetify
