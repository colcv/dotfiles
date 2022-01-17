local _, tmux = pcall(require, "tmux")

tmux.setup {
  copy_sync = {
    enable = false,
  },
  navigation = {
    enable_default_keybindings = true,
  },
  resize = {
    enable_default_keybindings = false,
  },
}
