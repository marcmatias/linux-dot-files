set encoding=utf-8

" # Vimwiki prerequisites
" Disable compatibility with vi mode
set nocompatible
" Load specific plugins based on file type
filetype plugin on
" Adjust indent based on file type
syntax on
" End Vimwiki prerequisites

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

" Line break
set list
"set listchars=eol:↳,
set listchars=trail:·

" Number of columns to move the line when using editing commands
set shiftwidth=2

" Show line numbers in netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

autocmd FileType markdown setlocal spell spelllang=en_us,pt_br
autocmd FileType markdown set tabstop=2 textwidth=80

" Treat all .md files as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
let g:markdown_fenced_languages = [
      \ 'typescript',
      \ 'python',
      \ 'ruby',
      \ 'go',
      \ 'javascript',
      \ 'bash'
      \]

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
set undodir=~/.vimundo/

" Add mapping for CTRL+SHIFT+C to copy selected text to clipboard wayland
xnoremap <silent> <C-S-C> :w !wl-copy<CR><CR>

" Powerline config
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" Minibar showing actual file
" set laststatus=2

" # Plugins
filetype indent on
if !has('nvim')
  packadd editorconfig
  packadd comment
endif
" End Plugins

" # Coc Settings
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-prettier',
      \ ]

" Activate :Prettier command
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" End Coc Settings

" # Vimwiki setup
let g:vimwiki_list = [{
      \ 'syntax': 'markdown',
      \ 'path': '~/Documents/Notes/',
      \ 'ext': 'md'
      \ }]

let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_hl_cb_checked = 1

" Restrict Vimwiki's operation to only those paths listed in g:vimwiki_list
let g:vimwiki_global_ext = 0

" Ignore Acessos folders
set wildignore+=*/Acessos/*

" Enalbe Acessos folders to Vimwiki link accesses
function! VimwikiFollowLinkBypass()
  " Save current wildignore
  let l:old_ignore = &wildignore
  " Remove temporary Acessos folder from wildignore
  set wildignore-=*/Acessos/*

  try
    " Try to execute default command to folow Vimwiki link
    call vimwiki#base#follow_link('nosplit', 0, 1)
  catch
    echo "Erro ao abrir link"
  finally
    " Restore ignore if success or error
    let &wildignore = l:old_ignore
  endtry
endfunction

" Apply this function inside Vimkiwi
augroup VimwikiLinkFix
    autocmd!
    autocmd FileType vimwiki nnoremap <buffer> <CR> :call VimwikiFollowLinkBypass()<CR>
augroup END

" Remove Enter key (<CR>) map with Insert mode in vimwiki buffers types to
" avoid conflits with Coc autocomplete
function! FixVimwikiEnter()
  if &filetype ==# 'vimwiki'
    silent! iunmap <buffer> <CR>

    inoremap <buffer> <silent><expr> <CR>
          \ coc#pum#visible() ? coc#pum#confirm() :
          \ "\<C-]>\<Esc>:VimwikiReturn 1 5\<CR>"
  endif
endfunction

autocmd FileType vimwiki call FixVimwikiEnter()
" End Vimwiki setup
