# for diff-highlight
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

# OS ごとの処理
case ${OSTYPE} in
    darwin*)
        export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        export ANDROID_HOME=$HOME/Library/Android/sdk
        export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
    ;;
esac

# 開発系のものを置く場所
mkdir -p ~/Developer

mkdir -p ~/.vim/colors
cp ~/.vim/dein/repos/github.com/reedes/vim-colors-pencil/colors/pencil.vim ~/.vim/colors/pencil.vim

## starship 初期化
eval "$(starship init zsh)"
