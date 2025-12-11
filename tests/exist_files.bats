#!/usr/bin/env bats

@test "exist dotfiles after installation" {
    files_exists=(
        "${HOME}/.config/ghostty/config"
        "${HOME}/.config/starship.toml"
        "${HOME}/.config/karabiner/karabiner.json"
        "${HOME}/.SpaceVim.d/init.toml"
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
