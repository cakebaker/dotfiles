" setup vim-plug
call plug#begin('~/.config/nvim/plugged')

" color scheme
Plug 'rafamadriz/neon'

" A collection of common configurations for Neovim's built-in language server client
Plug 'neovim/nvim-lspconfig'

" Adds extra functionality over rust analyzer
Plug 'simrat39/rust-tools.nvim'

Plug 'rust-lang/rust.vim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Syntax-highlighting for '.toml' files
Plug 'cespare/vim-toml'

call plug#end()

colorscheme neon

set completeopt=menu,menuone,noselect

set number " show line numbers

set scrolloff=3 " minimal number of screen lines to keep above and below the cursor

set signcolumn=yes " show signcolumn

set expandtab     " auto expand tabs to spaces
set tabstop=2     " a tab is two spaces
set shiftwidth=2  " number of spaces to use when indenting
set softtabstop=2 " number of spaces that a tab counts for while performing editing operations

set wrap      " wrap long lines
set linebreak " smarter wrapping of long lines

set clipboard+=unnamedplus " always use system clipboard

lua << EOF
  require('rust-tools').setup({})
EOF

lua <<EOF
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

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

EOF

let g:rustfmt_autosave = 1 " run rustfmt on save, provided by rust.vim 

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" more natural navigation for wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

set smartindent " smart autoindenting when starting a new line

set ignorecase " ignore case when searching
set infercase  " adjust case of match depending on the typed text when doing keyword completion in insert mode
set smartcase  " ignore case if search pattern is lowercase, case-sensitive otherwise

