set encoding=utf-8
syntax enable

" Copy to X11 clipboard
set clipboard=unnamedplus

" Show numbers
set number

" Show searchs
set incsearch

" Automatic indent
set autoindent

" Convert tabs to spaces
set expandtab

" Number of columns for a smooth tabulation
set softtabstop=2

" Number of columns to move the line when using editing commands
set shiftwidth=2

" Show line numbers in netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

autocmd FileType markdown setlocal spell spelllang=en_us,pt_br
autocmd FileType markdown set tabstop=2

" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
let g:markdown_fenced_languages = ['typescript', 'python', 'ruby', 'go', 'javascript', 'bash']

" Setting a theme
colorscheme molokai

" Show cursor line
set cursorline

" Set more variable colors
set termguicolors

" Force background transparent in personalized themes
hi Normal guibg=NONE ctermbg=NONE

" Highlight white spaces
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=/home/marcmatias/.vimundo/

" Powerline config
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup

" Minibar showing actual file
" set laststatus=2

" Plugins
filetype plugin indent on
if !has('nvim')
  packadd editorconfig
  packadd comment
endif

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Add mapping for CTRL+SHIFT+C to copy selected text to clipboard wayland
xnoremap <silent> <C-S-C> :w !wl-copy<CR><CR>
