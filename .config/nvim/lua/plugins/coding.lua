return {
  -- GitHub Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<Tab>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<M-\\>',
          },
        },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
    end,
  },

  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  -- LineDiff
  {
    'AndrewRadev/linediff.vim',
    cmd = 'Linediff',
    keys = {
      { '<leader>ld', ':Linediff<CR>', mode = 'x', desc = 'Line Diff' },
      { '<leader>lr', ':LinediffReset<CR>', desc = 'Line Diff Reset' },
    },
  },

  -- CopilotChat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'github/copilot.vim',
      'nvim-lua/plenary.nvim',
    },
    -- keys = {
    --   { '<leader>ccb', '<cmd>CopilotChatBuffer<cr>', desc = 'CopilotChat - Buffer' },
    --   { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain' },
    --   { '<leader>ccr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review' },
    --   { '<leader>ccf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - Fix' },
    --   { '<leader>cco', '<cmd>CopilotChatOptimize<cr>', desc = 'CopilotChat - Optimize' },
    --   { '<leader>ccd', '<cmd>CopilotChatDocs<cr>', desc = 'CopilotChat - Docs' },
    --   { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Tests' },
    --   { '<leader>ccF', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
    --   { '<leader>ccc', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Commit' },
    --   { '<leader>ccC', '<cmd>CopilotChatCommitStaged<cr>', desc = 'CopilotChat - Commit Staged' },
    --   { '<leader>ccR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor' },
    --   { '<leader>ccv', ':CopilotChatVisual<cr>', mode = 'x', desc = 'CopilotChat - Visual' },
    --   { '<leader>ccx', ':CopilotChatInPlace<cr>', mode = 'x', desc = 'CopilotChat - In Place' },
    -- },
    -- config = function()
    --   -- SSL certificate settings
    --   vim.g.copilot_chat_proxy = ''  -- Clear any proxy settings
    --   vim.g.copilot_chat_proxy_strict_ssl = false  -- Disable strict SSL checking

    --   require('CopilotChat').setup({
    --     debug = true,
    --     proxy = '',  -- Clear proxy settings
    --     proxy_strict_ssl = false,  -- Disable strict SSL
    --   })
    -- end,
  },

  -- Snippets
  {
    'Shougo/neosnippet',
    dependencies = {
      'Shougo/neosnippet-snippets',
      'honza/vim-snippets',
      'rcmdnk/vim-octopress-snippets',
    },
    event = 'InsertEnter',
    config = function()
      vim.g.neosnippet_enable_snipmate_compatibility = 1
      vim.g.neosnippet_disable_runtime_snippets = { _= 1 }
      vim.g.neosnippet_snippets_directory = {
        vim.fn.stdpath('data') .. '/lazy/neosnippet-snippets/neosnippets',
        vim.fn.stdpath('data') .. '/lazy/vim-snippets/snippets',
        vim.fn.stdpath('data') .. '/lazy/vim-octopress-snippets/neosnippets',
      }

      vim.keymap.set('i', '<C-s>', '<Plug>(neosnippet_expand_or_jump)')
      vim.keymap.set('s', '<C-s>', '<Plug>(neosnippet_expand_or_jump)')
      vim.keymap.set('x', '<C-s>', '<Plug>(neosnippet_expand_target)')
    end,
  },

  -- LSP and completion
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'j-hui/fidget.nvim',
    },
    config = function()
      -- Mason setup
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'ruff',
          'ts_ls',
          'rust_analyzer',
          'marksman',      -- Markdown
          'texlab',        -- LaTeX
          'terraformls',   -- Terraform
        },
        automatic_installation = true,
      })

      -- Completion setup
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        preselect = cmp.PreselectMode.None,  -- Disable preselection
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'  -- Prevent automatic selection
        },
      })

      -- LSP setup
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      -- Diagnostic configuration for real-time feedback
      local diagnostic_enabled = true  -- Track diagnostic state
      local saved_signcolumn = vim.opt.signcolumn:get()  -- Store original signcolumn value
      local saved_spell = vim.opt.spell:get()  -- Store original spell check state
      local saved_list = vim.opt.list:get()  -- Store original list state
      local saved_colorcolumn = vim.opt.colorcolumn:get()  -- Store original colorcolumn value

      -- Function to toggle diagnostics
      local function toggle_diagnostics()
        diagnostic_enabled = not diagnostic_enabled
        if diagnostic_enabled then
          vim.diagnostic.show()
          vim.opt.signcolumn = saved_signcolumn  -- Restore original signcolumn
          vim.opt.spell = saved_spell  -- Restore original spell check
          vim.opt.list = saved_list  -- Restore original list state
          vim.opt.colorcolumn = saved_colorcolumn  -- Restore original colorcolumn
          vim.cmd('IndentGuidesEnable')  -- Enable indent guides
          -- Re-enable diagnostic features
          vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            float = {
              border = 'rounded',
              source = 'always',
              header = '',
              prefix = '',
            },
          })
        else
          vim.diagnostic.hide()
          saved_signcolumn = vim.opt.signcolumn:get()  -- Save current signcolumn value
          saved_spell = vim.opt.spell:get()  -- Save current spell check state
          saved_list = vim.opt.list:get()  -- Save current list state
          saved_colorcolumn = vim.opt.colorcolumn:get()  -- Save current colorcolumn value
          vim.opt.signcolumn = "no"  -- Hide signcolumn
          vim.opt.spell = false  -- Disable spell check
          vim.opt.list = false  -- Disable list
          vim.opt.colorcolumn = ""  -- Hide colorcolumn
          vim.cmd('IndentGuidesDisable')  -- Disable indent guides
          -- Disable all diagnostic features
          vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = false,
            float = false,
          })
          -- Close any open float windows
          vim.diagnostic.hide()
        end
      end

      -- Add keymap to toggle diagnostics
      vim.keymap.set('n', '<leader>t', toggle_diagnostics, { noremap = true, silent = true, desc = 'Toggle Diagnostics' })

      -- Create diagnostic popup on cursor hold
      local diagnostic_group = vim.api.nvim_create_augroup('diagnostic_popup', { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = diagnostic_group,
        callback = function()
          if diagnostic_enabled then
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = 'rounded',
              source = 'always',
              prefix = ' ',
              scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
          end
        end
      })

      vim.diagnostic.config({
        virtual_text = false,       -- Disable virtual text by default
        signs = true,               -- Always show signs in the gutter
        underline = true,           -- Underline problems
        update_in_insert = true,    -- Update diagnostics in insert mode
        severity_sort = true,       -- Sort diagnostics by severity
        float = {                   -- Configure diagnostic float window
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      -- Diagnostic signs with more visible icons
      local signs = {
        Error = "E",  -- Error sign
        Warn  = "W",  -- Warning sign
        Hint  = "H",  -- Hint sign
        Info  = "I",  -- Info sign
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- LSP keymaps
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)

        -- Diagnostic navigation
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
        vim.keymap.set('n', '[e', function()
          vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'Go to previous error' })
        vim.keymap.set('n', ']e', function()
          vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'Go to next error' })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic in float window' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Add diagnostics to location list' })
      end

      -- Configure LSP servers
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        ruff = {
          settings = {
            args = {},
            settings = {
              -- Ruff settings
              lint = {
                args = {
                  "--select=ALL",  -- Enable all rules
                  "--ignore=D,ERA,UP,ANN", -- Ignore specific rules
                },
              },
              organizeImports = {
                enabled = true,
              },
              fixAll = {
                enabled = true,
              },
            },
          },
        },
        ts_ls = {},  -- TypeScript LSP
        rust_analyzer = {},

        -- Markdown
        marksman = {},

        -- LaTeX
        texlab = {
          settings = {
            texlab = {
              build = {
                onSave = true,
              },
              chktex = {
                onEdit = true,
                onOpenAndSave = true,
              },
              formatterLineLength = 80,
            },
          },
        },

        -- Terraform
        terraformls = {
          filetypes = { "terraform", "tf", "terraform-vars" },
        },
      }

      -- Setup all servers
      for server, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

      -- Setup fidget for LSP progress
      require('fidget').setup()

      -- Copilot setup
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""

      -- Custom function to handle Tab key
      local function tab_complete()
        local copilot_suggestion = require("copilot.suggestion")
        if copilot_suggestion.is_visible() then
          copilot_suggestion.accept()
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          -- Get the current shiftwidth value
          local sw = vim.bo.shiftwidth
          -- Create a string with that many spaces
          local spaces = string.rep(' ', sw)
          -- Return the spaces
          return spaces
        end
      end

      -- Map Tab key
      vim.keymap.set('i', '<Tab>', tab_complete, {
        expr = true,
        replace_keycodes = false
      })
      vim.keymap.set('i', '<S-Tab>', function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })
    end,
  },

  -- Shell script linting with nvim-lint
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Configure diagnostic signs
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
          },
        },
        virtual_text = false,        -- Disable virtual text
        signs = true,               -- Show signs
        underline = true,           -- Show underlines
        update_in_insert = false,   -- Don't update diagnostics in insert mode
        severity_sort = true,       -- Sort diagnostics by severity
      })

      -- Configure linters by filetype
      require('lint').linters_by_ft = {
        sh = {'shellcheck'},
        bash = {'shellcheck'},
        zsh = {'shellcheck'},
      }

      -- Automatically lint on certain events
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- Language specific plugins
  {
    'lervag/vimtex',
    ft = { 'tex', 'latex' },
    config = function()
      vim.g.tex_flavor = 'latex'
    end,
  },

  {
    'hashivim/vim-terraform',
    ft = { 'terraform', 'tf', 'terraform-vars' },
  },

  {
    'rcmdnk/vim-markdown',
    ft = { 'markdown', 'md' },
    dependencies = {
      'joker1007/vim-markdown-quote-syntax',
    },
    config = function()
      vim.g.vim_markdown_liquid = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_better_folding = 1
      vim.g.vim_markdown_folding_level = 6
      vim.g.vim_markdown_emphasis_multiline = 0

      -- Set markdown filetype for txt and text files
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { '*.txt', '*.text', '*.html' },
        command = 'setlocal filetype=markdown',
      })
    end,
  },
}
