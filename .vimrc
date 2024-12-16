""
"" Basic Setup
""

set nocompatible                    " Be iMproved
set encoding=utf-8                  " Set default encoding to UTF-8
set relativenumber number           " Show line numbers
set ruler                           " Show line and column number
set laststatus=2                    " Always show the status line
set showmode                        " Display the current mode
set showcmd                         " Display the number of selected rows in select mode
set cursorline                      " Highlight current line
set hidden                          " Allow buffer switching without saving
filetype plugin indent on           " Automatically detect file types
syntax on                           " Syntax highlighting
set signcolumn=yes                  " Always show the signcolumn
set updatetime=300                  " Smaller updatetime for CursorHold & CursorHoldI
set wildmenu                        " Show list instead of just completing

""
"" Color
""

color tokyonight256_moon           " Load a colorscheme
if has("termguicolors")
  set termguicolors                 " Enable true color support
end

""
"" Whitespace
""

set nowrap                          " Do not wrap long lines
set tabstop=2                       " An indentation every two columns
set softtabstop=2                   " Let backspace delete indent
set shiftwidth=2                    " Use indents of 2 spaces
set expandtab                       " Tabs are spaces, not tabs
set list                            " Show invisible characters
set backspace=indent,eol,start      " Backspace for dummies

" List chars
set listchars=""                    " Reset the listchars
set listchars=tab:\ \               " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.              " show trailing spaces as dots
set listchars+=extends:>            " The character to show in the last column when wrap is
                                    " off and the line continues beyond the right of the screen
set listchars+=precedes:<           " The character to show in the last column when wrap is
                                    " off and the line continues beyond the left of the screen

""
"" Backup and swap files
""

set nobackup                        " in this age of version control, who needs it
set nowritebackup                   " don't make a backup before overwriting
set backupdir^=~/.vim/_backup//     " Where to put backup files
set directory^=~/.vim/_temp//       " Where to put swap files
set undodir^=~/.vim/_undo//         " Where to put undo files
set undofile                        " persistent undos - undo after you re-open the file

""
"" Searching
""

set hlsearch                        " Highlight search terms
set incsearch                       " Find as you type search
set ignorecase                      " Case insensitive search
set smartcase                       " Case sensitive when uc present

""
"" Basic Keymaps
""

let mapleader = ','                 " set <Leader>

" Seamlessly treat visual lines as actual lines when moving around
noremap j gj
noremap k gk

" Use CTRL-L to clear the highlighting of 'hlsearch'
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Autoformat
noremap <leader>f :Autoformat<CR>
let g:formatdef_google_java_format = '"google-java-format -"'
let g:formatters_java = ['google_java_format']

""
"" Plugins
""

if has('syntax') && has('eval')
  packadd! matchit                  " makes % command work better (not backward-compatible)
endif

packadd minpac
call minpac#init()

call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('thinca/vim-visualstar')
call minpac#add('tpope/vim-surround')
call minpac#add('vim-autoformat/vim-autoformat')
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-commentary')
call minpac#add('bronson/vim-trailing-whitespace')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tomtom/tlib_vim')
call minpac#add('marcweber/vim-addon-mw-utils')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')
call minpac#add('mileszs/ack.vim')
call minpac#add('lifepillar/vim-colortemplate', {'type':'opt'})
call minpac#add('k-takata/minpac', {'type':'opt'})

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" SnipMate
:imap <C-J> <Plug>snipMateNextOrTrigger
:smap <C-J> <Plug>snipMateNextOrTrigger

" ACK
cnoreabbrev Ack Ack!
nnoremap <Leader>F :Ack!<Space>
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" CtrlP
if executable('rg')
  " Use rg over Grep
  set grepprg=rg\ --vimgrep
  " Use rg in CtrlP for listing files.
  let g:ctrlp_user_command = 'rg %s --files'
  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
endif

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Fugitive
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gl :Gclog<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
