#!/usr/bin/env bats

@test "exist dotfiles after installation" {
    files_exists=(
        "${HOME}/.config/ghostty/config"
        "${HOME}/.config/starship.toml"
        "${HOME}/.config/sheldon/plugins.toml"
        "${HOME}/.config/chezmoi/chezmoi.toml"
        "${HOME}/.config/zed/settings.json"
        "${HOME}/.config/karabiner/karabiner.json"
        "${HOME}/.Brewfile"
        "${HOME}/.gitconfig"
        "${HOME}/.zshrc"
        "${HOME}/.zshenv"
        "${HOME}/.zprofile"
    )
    for file in "${files_exists[@]}"; do
        [ -f "${file}" ]
    done
}
