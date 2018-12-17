module.exports = {
  config: {
    fontSize: 14,
    fontFamily: '"Source Han Code JP"',
    pokemon: ['Poliwhirl'],
    unibody: 'true',
    poketab: 'true',
    opacity: 0.9,
    summon: {
      hideDock: true,
      hideOnBlur: true,
      hotkey: 'Ctrl+T'
    },
  },  
  plugins: [
    'hyper-statusline',
    'hyper-tab-icons-plus',
    'hyper-pokemon',
    'hyper-search',
    'hyper-opacity',
    'hyperlinks',
    'hyperterm-summon'
  ]
};
