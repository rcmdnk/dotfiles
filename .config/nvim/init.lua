-- init.lua

-- Set <space> as the leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Lazy plugin manager
require("config.lazy")

-- Load configurations
require('config.options')
require('config.keymaps')
require('config.autocmds') 
