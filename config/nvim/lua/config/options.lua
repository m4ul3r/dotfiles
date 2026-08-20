-- remote_clipboard.lua is installed by omarchy migration 1781587663, not
-- tracked here; guard so a fresh stow before that migration still starts.
pcall(function() require("config.remote_clipboard").setup() end)
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
