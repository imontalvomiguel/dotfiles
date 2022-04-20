""
"" Basic Setup
""

set nocompatible                    " Must be first line
set number                          " Line numbers on
set ruler                           " Show the ruler
set showmode                        " Display the current mode
set showcmd                         " Show partial commands in status line and
set cursorline                      " Highlight current line
set hidden                          " Allow buffer switching without saving
filetype plugin indent on           " Automatically detect file types
syntax on                           " Syntax highlighting
set shortmess+=c                    " Don't give ins-completion-menu messages

" Neovim disallow changing 'enconding' option after initialization
if !has('nvim')
  set encoding=utf-8                " Set default encoding to UTF-8
endif

if has('statusline')
  set laststatus=2                  " Always show the status bar

  " Start the status line
  set statusline=%f\ %m\ %r
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

""
"" Whitespace
"""

set nowrap                          " Do not wrap long lines
set tabstop=2                       " An indentation every two columns
set softtabstop=2                   " Let backspace delete indent
set shiftwidth=2                    " Use indents of 2 spaces
set expandtab                       " Tabs are spaces, not tabs
set list                            " Show invisible characters
set backspace=indent,eol,start      " Backspace for dummies

" Highlight problematic whitespace
set listchars=""                    " Reset the listchars
set listchars=tab:\ \               " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.              " show trailing spaces as dots
set listchars+=extends:>            " The character to show in the last column when wrap is
                                    " off and the line continues beyond the right of the screen
set listchars+=precedes:<           " The character to show in the last column when wrap is
                                    " off and the line continues beyond the left of the screen

""
"" Searching
""

set hlsearch                        " Highlight search terms
set incsearch                       " Find as you type search
set ignorecase                      " Case insensitive search
set smartcase                       " Case sensitive when uc present

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup//     " Where to put backup files
set directory^=~/.vim/_temp//       " Where to put swap files

" Some servers have issues with backup files, see neoclide/coc.nvim#649.
set nobackup
set nowritebackup

"" Plugins
""

" Matchit
packadd! matchit

" Minpac
packadd minpac
call minpac#init()

call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-fugitive')
call minpac#add('preservim/tagbar')
call minpac#add('preservim/nerdtree')
call minpac#add('preservim/nerdcommenter')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('bronson/vim-trailing-whitespace')
call minpac#add('elzr/vim-json')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tomtom/tlib_vim')
call minpac#add('marcweber/vim-addon-mw-utils')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')
call minpac#add('mileszs/ack.vim')
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('mattn/emmet-vim')
call minpac#add('dracula/vim')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('ap/vim-css-color')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('prettier/vim-prettier')
call minpac#add('k-takata/minpac', {'type': 'opt'})

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" JSON
let g:vim_json_syntax_conceal = 0

" SnipMate
let g:snipMate = { 'snippet_version' : 1 }

" Dracula
let g:dracula_italic = 0
colorscheme dracula

" ACK
cnoreabbrev Ack Ack!

""
"" Key (re)Mappings
""

" Mapleader
let mapleader = ','

" Wrapped lines goes down/up to next row, rather than next line in file
noremap j gj
noremap k gk

" SnipMate
:imap <C-J> <Plug>snipMateNextOrTrigger
:smap <C-J> <Plug>snipMateNextOrTrigger

" NerdTree
map <leader>e :NERDTreeFind<CR>
map <leader>n :NERDTreeToggle<CR>

" Fugitive
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gl :Gclog<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gp :Git push<CR>

" ACK
nnoremap <Leader>f :Ack!<Space>

" COC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
