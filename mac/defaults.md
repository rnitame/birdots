# スクショ
## 影を削除する
defaults write com.apple.screencapture "disable-shadow" -bool "true"

## 画像形式変更
defaults write com.apple.screencapture "type" -string "png"

# Finder
## デフォルトでリストビューにする
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"

## デフォルトで隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true

## 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true

## パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true

# その他
## DS_Store 作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

## Dock を自動的に隠す
defaults write com.apple.dock autohide -bool true

# メニューバー
## バッテリーの % を表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

## 音量アイコンをMenuBarに表示
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" 1
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"

## BluetoothアイコンをMenuBarに表示
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" 1
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"