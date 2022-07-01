# for diff-highlight & ruby
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight:/usr/local/sbin:$HOME/.rbenv/bin

# OS ごとの処理
case ${OSTYPE} in
    darwin*)
        export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        export ANDROID_HOME=$HOME/Library/Android/sdk
        export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
    ;;
esac

## starship 初期化
eval "$(starship init zsh)"

## rbenv 初期化
eval "$(rbenv init -)"


## zplugin
source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light b4b4r07/enhancd
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

autoload -U compinit
compinit

## hyper の設定
export LANG=ja_JP.UTF-8

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
tabtitle_precmd() {
   if overridden; then return; fi
   pwd=$(pwd) # Store full path as variable
   cwd=${pwd##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions tabtitle_precmd)

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
tabtitle_preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions tabtitle_preexec)

function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

# cd なしで移動
setopt auto_cd
setopt auto_pushd

alias ls='exa'
alias ll='exa -ahl --git'
alias less='bat'
alias cat='bat'

# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/Users/tummy/Library/Preferences/netlify/helper/path.zsh.inc' && source '/Users/tummy/Library/Preferences/netlify/helper/path.zsh.inc'