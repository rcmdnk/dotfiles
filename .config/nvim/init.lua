-- init.lua

-- Following global variables must be set before loading lazy
require("config.globals")

-- -- Lazy plugin manager
require("config.lazy")

-- Load configurations
require('config.options')
require('config.autocmds')
require('config.format')
require('config.keymaps')
