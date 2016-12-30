# OS ごとの処理
case ${OSTYPE} in
    darwin*)
        export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    ;;
esac

mkdir -p ~/.vim/colors
cp ~/.vim/dein/repos/github.com/reedes/vim-colors-pencil/colors/pencil.vim ~/.vim/colors/pencil.vim

# zplug
## インストールチェック
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", \
    defer:10
zplug "zsh-users/zsh-completions"
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
zplug "b4b4r07/enhancd", \
    use:init.sh
zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:fzf
zplug "junegunn/fzf", \
    as:command, \
    use:bin/fzf-tmux
zplug "olivierverdier/zsh-git-prompt", \
    use:zshrc.sh

## インストールしてないプラグインがあればインストール
if ! zplug check --verbose; then
    printf "zplug plugin Install? [y/N] : "
    if read -q; then
        echo; zplug install
    fi
fi

## プラグイン読み込み、コマンドパス追加
zplug load --verbose

###############
# zsh Setting 
###############

###############
# ヒストリ関連
###############
# 履歴の保存先
HISTFILE=$HOME/.zsh-history
## メモリに展開する履歴の数
# HISTSIZE=10000
## 保存する履歴の数
SAVEHIST=10000

## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## 余分な空白は詰めて記録
setopt hist_reduce_blanks  
## 古いコマンドと同じものは無視 
setopt hist_save_no_dups
## ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
## 補完時にヒストリを自動的に展開         
setopt hist_expand

## Screenでのコマンド共有用
## シェルを横断して.zshhistoryに記録
setopt inc_append_history
## ヒストリを共有
setopt share_history

###################
# ディレクトリ変更
###################
## ディレクトリ名だけで cd
setopt auto_cd
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

############
# 補間関連
############
## 補完機能の有効
autoload -U compinit
compinit

## TAB で順に補完候補を切り替える
setopt auto_menu
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## 補完候補を詰めて表示
setopt list_packed

#########
# グロブ
#########
## 拡張グロブを使用
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

##########
# 入出力
##########
## 出力時8ビットを通す
setopt print_eight_bit
## スペルチェック。間違うと訂正してくれる
setopt correct
## PCRE 互換の正規表現を使う
setopt re_match_pcre
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

##################
# プロンプト関連
##################
# 色有効
autoload -U colors
colors

# プロンプト
autoload -Uz vcs_info
zstyle ':completion:*' special-dirs true
setopt prompt_subst

if (( $+functions[git_super_status] )); then
    ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
    ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{● %}"
    ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖ %}"
    ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚ %}"
    ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%}"
    ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%}"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%}"
    ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔ %}"
    PROMPT='$(git_super_status)'
fi

PROMPT+="
%F{cyan}[%~]%f%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!( ´-｀) <!( ´;-;｀%)? <)%{${reset_color}%} "


# プロンプト指定(コマンドの続き)
PROMPT2='[%n]> '

# もしかして時のプロンプト指定
SPROMPT="%{$fg[red]%}%{$suggest%}( ･´ｰ･｀)? < もしかして %B%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),a,e]: %{${reset_color}%}"

##############
# ジョブ制御
##############
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

#################
# その他・未分類
#################
## コアダンプサイズを制限
# limit coredumpsize 102400

## ビープを鳴らさない
setopt nobeep

#########
# Alias 
#########
alias ls='ls -F --color=auto'
alias ll='ls -ltr'
alias la='ls -a'
alias lal='ls -al'
alias vi='vim'
alias tmux="TERM=xterm-256color tmux -2"

## tmux の自動起動
if [[ ! -n $TMUX && $- == *l* ]]; then
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | $PERCOL | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
        tmux new-session
    elif [[ -n "$ID" ]]; then
        tmux attach-session -t "$ID"
    else
        :  # 通常通り起動 
    fi
fi

## ファイルが多いディレクトリでlsしたとき短縮して表示
ls_abbrev() {
    if [[ ! -r $PWD ]]; then
        return
    fi
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

## Enter を打った時にlsとgit statusを実行
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev
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


## for golang
export GOPATH=~/golang
export GOROOT=$(go env GOROOT)
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
