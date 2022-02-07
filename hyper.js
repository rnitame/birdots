module.exports = {
  config: {
    fontSize: 15,
    fontFamily: 'Noto Mono for Powerline, Menlo, monospace',
    opacity: 0.9,
    summon: {
      hideDock: true,
      hideOnBlur: true,
      hotkey: 'Ctrl+T'
    },
    shell: "/usr/local/bin/zsh"
  },  
  plugins: [
    'hyper-dracula',
    'hyper-tab-icons-plus',
    'hyper-opacity',
    'hyperlinks',
    'hyperterm-summon'
  ],
  localPlugins:[
    'hyper-statusline'
  ]
};
