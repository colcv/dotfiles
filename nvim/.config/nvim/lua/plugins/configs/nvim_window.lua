local _, nvim_window = pcall(require, 'nvim-window')

nvim_window.setup {
  chars = {
    'z',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
  },
  normal_hl = 'NvimWindow',
  hint_hl = 'Bold',
  border = 'none',
}
