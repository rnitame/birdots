#!/usr/bin/env bats

@test "exist dotfiles after installation" {
    files_exists=(
        "${HOME}/.config/ghostty/config"
        "${HOME}/.config/starship.toml"
        "${HOME}/.config/sheldon/plugins.toml"
        "${HOME}/.config/mise/config.toml"
        "${HOME}/.config/zed/settings.json"
        "${HOME}/.homebrew/Brewfile"
        "${HOME}/.gitconfig"
        "${HOME}/.zshrc"
        "${HOME}/.zshenv"
        "${HOME}/.zprofile"
    )
    for file in "${files_exists[@]}"; do
        [ -f "${file}" ]
    done
}
