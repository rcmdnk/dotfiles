-- init.lua

-- Following global variables must be set before loading lazy

-- Set <space> as the leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Disable clipboard integration
-- To fix this issue, need COLORTERM=truecolor in bash env and this setting in nvim
-- [DECRQSS +q5463;524742;73657472676266;73657472676262$qm appears in terminal · Issue #28776 · neovim/neovim](https://github.com/neovim/neovim/issues/28776)
vim.g.clipboard = false

-- Lazy plugin manager
require("config.lazy")

-- Load configurations
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.format') 
