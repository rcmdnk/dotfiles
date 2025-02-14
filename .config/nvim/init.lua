-- init.lua

-- Set <space> as the leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Install package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup('plugins', {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'tokyonight' },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- Load configurations
require('config.options')
require('config.keymaps')
require('config.autocmds') 