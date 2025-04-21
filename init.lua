local vim = vim
local Plug = vim.fn['plug#']

-- setup vim-plug
vim.call('plug#begin', '~/.config/nvim/plugged')

-- color scheme
Plug 'rafamadriz/neon'

-- A collection of common configurations for Neovim's built-in language server client
Plug 'neovim/nvim-lspconfig'

-- Adds extra functionality over rust analyzer
Plug 'simrat39/rust-tools.nvim'

-- Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

vim.call('plug#end')

vim.cmd('colorscheme neon')

vim.cmd('set completeopt=menu,menuone,noselect')

vim.opt.number = true      -- show line numbers
vim.opt.signcolumn = 'yes' -- show signcolumn

vim.opt.cursorline = true  -- highlight current line
vim.opt.scrolloff = 3      -- minimal number of screen lines to keep above and below the cursor

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

vim.opt.expandtab = true -- auto expand tabs to spaces
vim.opt.tabstop = 2      -- a tab is two spaces
vim.opt.shiftwidth = 2   -- number of spaces to use when indenting
vim.opt.softtabstop = 2  -- number of spaces that a tab counts for while performing editing operations

vim.opt.wrap = true      -- wrap long lines
vim.opt.linebreak = true -- smarter wrapping of long lines

vim.cmd('set clipboard+=unnamedplus') -- always use system clipboard

require('rust-tools').setup({})

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    -- keyword_pattern is needed for autocompletion of words with umlauts
    { name = 'buffer', option = { keyword_pattern = [[\k\+]] }},
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.cmd('nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>')

-- more natural navigation for wrapped lines
vim.cmd('nnoremap j gj')
vim.cmd('nnoremap k gk')
vim.cmd('nnoremap <Down> gj')
vim.cmd('nnoremap <Up> gk')

vim.opt.smartindent = true -- smart autoindenting when starting a new line

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.infercase = true  -- adjust case of match depending on the typed text when doing keyword completion in insert mode
vim.opt.smartcase = true  -- ignore case if search pattern is lowercase, case-sensitive otherwise

-- format on save
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        vim.lsp.buf.format { bufnr = args.buf, id = args.data.client_id }
      end,
    })
  end
})
