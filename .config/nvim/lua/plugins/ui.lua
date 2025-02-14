return {
  -- Color scheme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'night',
        light_style = 'day',
        dim_inactive = false,
        on_colors = function(colors)
          colors.bg = '#000000'
          colors.border = colors.blue7
        end,
        on_highlights = function(highlights, colors)
          highlights.DiffAdd = {
            bg = '#c53b53',
            fg = 'NONE'
          }
          highlights.DiffChange = {
            bg = '#3b4261',
            fg = 'NONE'
          }
          highlights.DiffDelete = {
            bg = '#4c2a2a',
            fg = 'NONE'
          }
          highlights.DiffText = {
            bg = '#c53b53',
            fg = 'None',
          }
          highlights.SignColumn = {
            bg = '#1f2335',
            fg = '#a9b1d6',
          }
          highlights.CocGitAddedSign = {
            bg = '#1f2335',
            fg = 'None',
          }
        end,
      })
      vim.cmd.colorscheme('tokyonight')
    end,
  },

  -- Status line
  {
    'itchyny/lightline.vim',
    lazy = false,
    config = function()
      vim.g.lightline = {
        colorscheme = 'tokyonight',
        active = {
          left = {{'mode', 'paste'}, {'filename', 'modified'}},
          right = {{'lineinfo'}, {'percent'}, {'fileformat', 'fileencoding', 'filetype'}}
        },
        component_function = {
          mode = 'LightlineMode',
          filename = 'LightlineFilename',
        },
      }
    end,
  },

  -- Indent guides
  {
    'nathanaelkane/vim-indent-guides',
    event = 'BufReadPre',
    config = function()
      -- Enable by default
      vim.g.indent_guides_enable_on_vim_startup = 1
      vim.g.indent_guides_start_level = 2
      vim.g.indent_guides_guide_size = 1
      vim.g.indent_guides_exclude_filetypes = {'help', 'nerdtree', 'tagbar'}
      vim.g.indent_guides_auto_colors = 0

      -- Set custom colors and ensure they're applied after colorscheme
      vim.api.nvim_create_autocmd({"VimEnter", "Colorscheme"}, {
        callback = function()
          -- Use more visible colors that work with tokyonight
          vim.cmd([[
            highlight IndentGuidesOdd  guibg=#232433 ctermbg=236
            highlight IndentGuidesEven guibg=#2c2e43 ctermbg=238
          ]])
        end,
      })

      -- Force enable for the first time
      vim.cmd('IndentGuidesEnable')
    end,
  },

  -- Fold
  {
    'Konfekt/FastFold',
    event = 'BufReadPre',
  },

  {
    'LeafCage/foldCC',
    event = 'BufReadPre',
    config = function()
      vim.opt.foldtext = 'FoldCCtext()'
    end,
  },

  -- Matching
  {
    'andymass/vim-matchup',
    event = 'BufReadPre',
  },

  -- File explorer
  {
    'scrooloose/nerdtree',
    cmd = 'NERDTreeToggle',
    keys = {
      { '<Leader>N', ':NERDTreeToggle<CR>', desc = 'Toggle NERDTree' },
    },
  },

  -- Tagbar
  {
    'majutsushi/tagbar',
    cmd = 'TagbarToggle',
    keys = {
      { '<Leader>T', ':TagbarToggle<CR>', desc = 'Toggle Tagbar' },
    },
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
} 