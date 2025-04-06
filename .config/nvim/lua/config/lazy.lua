-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- automatically check for plugin updates
  checker = {
    enabled = true,        -- Enable the update checker
    notify = false,         -- Show notification when updates are available
    frequency = 86400,     -- Check for updates once a day (in seconds)
    auto_update = true,    -- Automatically update plugins when updates are available
  },
  -- automatically install and update plugins
  install = {
    missing = true,        -- Install missing plugins on startup
    colorscheme = { "tokyonight" },  -- Try to load this colorscheme when installing plugins
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  -- automatically run :Lazy sync when plugins.lua is updated
  change_detection = {
    enabled = true,        -- Enable automatic detection of config changes
    notify = true,         -- Show notification when changes are detected
  },
})

