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

Plug 'rust-lang/rust.vim'

-- Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

vim.call('plug#end')

vim.cmd('colorscheme neon')

vim.cmd('set completeopt=menu,menuone,noselect')

vim.cmd('set number') -- show line numbers

vim.cmd('set scrolloff=3') -- minimal number of screen lines to keep above and below the cursor

vim.cmd('set signcolumn=yes') -- show signcolumn

vim.cmd('set expandtab')     -- auto expand tabs to spaces
vim.cmd('set tabstop=2')     -- a tab is two spaces
vim.cmd('set shiftwidth=2')  -- number of spaces to use when indenting
vim.cmd('set softtabstop=2') -- number of spaces that a tab counts for while performing editing operations

vim.cmd('set wrap')      -- wrap long lines
vim.cmd('set linebreak') -- smarter wrapping of long lines

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


vim.cmd('let g:rustfmt_autosave = 1') -- run rustfmt on save, provided by rust.vim 

vim.cmd('nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>')

-- more natural navigation for wrapped lines
vim.cmd('nnoremap j gj')
vim.cmd('nnoremap k gk')
vim.cmd('nnoremap <Down> gj')
vim.cmd('nnoremap <Up> gk')

vim.cmd('set smartindent') -- smart autoindenting when starting a new line

vim.cmd('set ignorecase') -- ignore case when searching
vim.cmd('set infercase')  -- adjust case of match depending on the typed text when doing keyword completion in insert mode
vim.cmd('set smartcase')  -- ignore case if search pattern is lowercase, case-sensitive otherwise
