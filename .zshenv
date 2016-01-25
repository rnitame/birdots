# rbenv
export PATH="$PATH:$HOME/.rbenv/shims/"
eval "$(rbenv init -)"

# nodebrew
if [[ -f ~/.nodebrew/nodebrew ]]; then
    export PATH="$PATH:$HOME/.nodebrew/current/bin"
    nodebrew use v0.10.22
fi

# phpenv
eval "$(phpenv init -)"
