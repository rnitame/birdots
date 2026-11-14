# birdots

mise の copy モードで設定を配置し、実ファイルの編集を好きなタイミングで birdots に取り込みます。mise 2026.11.8 以降を使用します。

## 初期配置

Homebrew と mise を用意して、このリポジトリで実行します。

```bash
mise trust
mise dot diff
mise dot apply
brew bundle --file="$HOME/.homebrew/Brewfile"
mise install
```

既存の設定と差分がある場合は、内容を確認・バックアップしてから適用してください。

## 日常の更新

`~/.zshrc` や `~/.homebrew/Brewfile` などを普段どおり編集し、birdots のディレクトリで実行します。

```bash
mise dot add --changed
git diff
git add -p
git commit -m "Update dotfiles"
git push
```

`mise dot add --changed` がコピー配置したファイルの編集を `home/` へ取り込みます。commit・push は自分で実行します。Brewfile はファイル自体の編集を取り込みます。インストール済みパッケージから再生成する場合は、先に `brew bundle dump --global --force` を実行します。

別の Mac の変更を取り込むときは、手元の編集を先に取り込んで commit してから実行します。

```bash
git pull --rebase
mise dot diff
mise dot apply
```

ツールや Brewfile が変わった場合は `mise install` や `brew bundle --file="$HOME/.homebrew/Brewfile"` も実行します。
