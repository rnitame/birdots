#!/usr/bin/env bats

@test "exist commands after installation" {
    commands_exists=(
        # mise で入れたもの
        "node --version"
    )
    for command in "${commands_exists[@]}"; do
        run ${command}

        # assert_success
        [ "$status" -eq 0 ]
    done
}
