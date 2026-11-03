# birdots

mise の track mode で実ファイルを管理します。ローカルの編集は自動で履歴へ保存し、リモートとの同期は手動で行います（mise 2026.10.25 以降、macOS）。

## 初期セットアップ

Xcode Command Line Tools と Homebrew を用意し、このリポジトリを clone します。

```bash
brew install mise
git clone git@github.com:rnitame/birdots.git
cd birdots
bash scripts/bootstrap.sh
```

既存の chezmoi 管理から移行する場合は、現在の設定を `home/` と比較してから実行します。

```bash
bash scripts/bootstrap.sh --migrate
```

異なる既存ファイルは `~/.local/state/birdots/backups/<日時>/` にバックアップしてから置き換えます。通常実行では差分があれば停止します。`--files-only` はファイル配置と初回履歴保存だけを行い、Homebrew・ツールのインストールとサービス登録を省略します。

`home/` は初期配置用のスナップショットです。日常の編集はホームディレクトリの実ファイルで行い、初期配置スクリプトは再同期には使いません。履歴は `~/.local/state/mise/history/repo.git` に保存され、通常の作業ツリーへ自動で戻ることはありません。初期配置用スナップショットを更新したい場合は、実ファイルを `home/` にコピーして通常の Git コミットを作成します。

## 手動同期

同期用の履歴には通常のソースブランチとは別の `mise-sync` ブランチを使います。最初のマシンで、一度だけ初期履歴を公開して接続します。

```bash
mise dot save
git -C ~/.local/state/mise/history/repo.git push \
  git@github.com:rnitame/birdots.git refs/heads/main:refs/heads/mise-sync
mise dot origin set git@github.com:rnitame/birdots.git \
  --branch mise-sync --sync manual --yes
```

公開前に追跡対象と履歴を確認してください。手動同期でも途中のコミットをすべて送信します。認証情報は追跡対象の外へ置きます。`config.local.toml` や `.env`、アプリの設定ディレクトリ全体は追跡しません。

別の Mac で初期配置済みの履歴と異なる履歴を接続すると衝突するため、同期先の履歴を採用してセットアップします。既存ファイルに差分がある場合は、先に内容を比較してバックアップします。

```bash
mise bootstrap --adopt 'git@github.com:rnitame/birdots.git?ref=mise-sync'
mise dot origin set git@github.com:rnitame/birdots.git \
  --branch mise-sync --sync manual --yes
```

日常の操作:

```bash
mise dot status           # 追跡対象・保存サービス・同期状態
mise dot history          # 保存履歴を確認
mise dot save             # watcher を待たずに現在の編集を保存
mise dot sync             # 保存済み履歴を push、リモートの履歴を fetch
mise dot pull             # fetch 済みの内容を実ファイルへ適用
mise install              # ツール設定が変わったとき
brew bundle --file="$HOME/.homebrew/Brewfile"  # Brewfile が変わったとき
```

`settings.history.sync = "manual"` なので、バックグラウンドの push・fetch・取り込みは行いません。保存サービスは `mise bootstrap services apply` で登録します。取り込みが衝突した場合は `mise dot conflicts` で確認し、`mise dot pull --take-remote <path>` または `--keep-local <path>` で解決します。

## 確認

```bash
mise dot status
mise settings get history.sync  # manual
bats -r tests
```

サービスが動かないときは `mise doctor` と `launchctl print gui/$(id -u)/dev.mise.mise-history` を確認します。
