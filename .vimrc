" Set mapleader to space bar
let mapleader=" "

" Use Vim settings rather than Vi settings
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Allow arrow/movement keys to move over newlines
set whichwrap+=<,>,h,l

" Keep 1000 lines of command line history
set history=1000

" Set maximum tab pages to 50
set tabpagemax=50

" Show cursor position all the time
set ruler

" Display incomplete commands
set showcmd

" Display completion matches in a status line
set wildmenu

" Disable timeouts for keymaps
set notimeout

" Show @@@ in the last line if it is truncated
set display=truncate

" Show a few lines of context around the cursor
set scrolloff=5

" Do incremental searching
if has('reltime')
  set incsearch
endif

" Use case insensitive search if searching via all lowercase
set ignorecase
set smartcase

" Highlight searched word
set hlsearch

" Clear highlighting
nnoremap <leader>x :nohlsearch<CR>
" nnoremap <leader>x :let @/ = ""<CR><C-L>

" Backspace to go to the beginning of the line
nnoremap <BS> ^

" Hide buffers instead of closing them when opening a new file
set hidden

" Do not recognize octal numbers for Ctrl-A and Ctrl-X
set nrformats-=octal

" Allow undo for Ctrl-U in insert mode
inoremap <C-U> <C-G>u<C-U>

" Enable mouse
if has('mouse')
  set mouse=a
endif

" Enable syntax highlighting when terminal has colors or using GUI
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Enable filetype specific settings
if has('autocmd')
  filetype plugin indent on
endif

" Add :Difforig command to show your changes to the file from the original
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Copy indent from current line when starting a new line
set autoindent

" Remove included files from insert mode completion, to prevent pollution
set complete-=i

" Use spaces rather than tabs of tabs for '<', '>', and autoindent
set expandtab

" Use spaces rather than tabs for insert/delete at the beginning of a line
set smarttab

" Round indent to multiple of shiftwidth when using '<' or '>'
set shiftround

" Set the width of tabs to be 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Always show status line
set laststatus=2

" Use utf-8 encoding
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" Display some whitespace characters and line wrap characters
set listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+
set list

" Toggle whitespace characters
noremap <leader>vw :set list!<CR>

" Remove comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Load matchit.vim
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Don't redraw while executing macros (for performance)
set lazyredraw

" Show matching bracket when a bracket is inserted for 200ms
set showmatch
set matchtime=2

" Disable bells on errors
set visualbell
set noerrorbells
set t_vb=
" Requires an autocmd when disabling errors for GUI
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Set colors, fonts and gui options
set background=dark
if &t_Co >= 256 || has("gui_running")
  try
    colorscheme solarized
  catch
    colorscheme desert
  endtry
  if has('win32')
    " For Win32 GUI, no tearoff menu entries and no icons
    set guioptions-=t
    set guioptions-=T
    " Remove menu bar, mostly to allow Meta key bindings
    set guioptions-=m
    " set the tab label to show 20 characters of the path
    set guitablabel=%N.%n\ %.20f\ %M
  endif
  " set the font
  set guifont=Consolas:h11
else
  colorscheme noctu
endif

" Set statusline
set statusline=%5l/%-5L
set statusline+=\ col:%3c
set statusline+=\ ascii:0x%B
set statusline+=\ %=%f%m%r
set statusline+=\ %{ALEGetStatusLine()}

" Set unix line endings for specific unix filetypes
if has('autocmd')
  autocmd Filetype sh setlocal fileformat=unix
  autocmd Filetype csh setlocal fileformat=unix
  autocmd Filetype tcsh setlocal fileformat=unix
  autocmd Filetype zsh setlocal fileformat=unix
endif

" Disable backup, don't pollute directories
set nobackup
set nowritebackup
set noswapfile

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-U>call VisualSelection('', '')<CR>/<C-R>=@<CR><CR>
vnoremap <silent> # :<C-U>call VisualSelection('', '')<CR>?<C-R>=@<CR><CR>

" Easier window management/navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-c> <C-w>c

" Buffer navigation
noremap <M-j> :bnext<CR>
noremap <M-k> :bprevious<CR>

" Create new buffer
noremap <leader>bn :enew<CR>

" Buffer close without closing window
noremap <leader>bc :bp<bar>sp<bar>bn<bar>bd<CR>

" Create new tab with current buffer
noremap <leader>tn :tab<space>split<CR>

" Close all tabs except for the current one
noremap <leader>to :tabonly<CR>

" Close the current tab
noremap <leader>tc :tabclose<CR>

" Move the current tab to the rightmost
noremap <leader>tm :tabmove<CR>

" Tab navigation
noremap <M-l> :tabnext<CR>
noremap <M-h> :tabprevious<CR>

" Maintain column for various commands
set nostartofline

" Confirm when trying to quit with unsaved changes
set confirm

" Show line numbers
set number

" Highlight the cursor line
set cursorline

" Make Y behave more similar to other shift commands (D, C, etc.)
nnoremap Y y$

" Enable perl/python regex when searching
nnoremap / /\v
vnoremap / /\v

" Strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Reformat leading tabs/spaces
nnoremap <leader>w :retab<CR>

" Use system clipboard by default
set clipboard=unnamed,unnamedplus

" Edit vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" Auto-reload vimrc on save
if has('autocmd')
  augroup reloadVimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  augroup END
endif

" Show only the status line for minimized windows
set winminheight=0

" Ignore certain file types for tab completion
set wildignore+=.git,*.swp,*.zip,*.exe,*.bak,*.pyc,*.class,*.o,*.obj,*.bin

" Raise permissions for saving files on unix
cmap w!! w !sudo tee % >/dev/null

" Delete to black hole register
nnoremap <M-d> "_d
vnoremap <M-d> "_d
nnoremap <M-c> "_c
vnoremap <M-c> "_c
nnoremap <M-x> "_x
vnoremap <M-x> "_x
nnoremap <M-s> "_s
vnoremap <M-s> "_s
vnoremap <M-p> "_dP

" If shift is accidentally held during write/quit
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Select all text
vnoremap A <Esc>ggVG

" Visually select the text that was last edited/pasted
nnoremap gV `[V`]

" Allow '<' and '>' to be matched with %
set matchpairs+=<:>

" Set tabs to two spaces for some file types
if has('autocmd')
  autocmd Filetype xml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype vim setlocal ts=2 sts=2 sw=2 expandtab
endif

"==============================================================================
" Plugin Configuration
"==============================================================================

"------------------------------------------------------------------------------
" netrw
"------------------------------------------------------------------------------
" Use tree view for netrw
let g:netrw_liststyle = 3
" Remove the top banner
let g:netrw_banner = 0

"------------------------------------------------------------------------------
" vim-rooter
"------------------------------------------------------------------------------
let g:rooter_use_lcd = 1 " set each dir local to the window
let g:rooter_resolve_links = 1 " resolve symbolic links

"------------------------------------------------------------------------------
" vim-wordmotion
"------------------------------------------------------------------------------
" Create our wordmotion keybindings
let g:wordmotion_mappings = {
\ 'w' : '<M-w>',
\ 'b' : '<M-b>',
\ 'e' : '<M-e>',
\ 'ge' : 'g<M-e>',
\ 'aw' : 'a<M-w>',
\ 'iw' : 'i<M-w>',
\ '<C-r><C-w>' : '<C-r><M-w>'
\ }
" define the '_', '-', and '.' as spaces so they are skipped/deleted
let g:wordmotion_spaces = '_-.'

"------------------------------------------------------------------------------
" ale
"------------------------------------------------------------------------------
" configure the message string
let g:ale_echo_msg_error_str = "E"
let g:ale_echo_msg_warning_str = "W"
let g:ale_echo_msg_format = "[%linter%] %s [%severity%]"
" only run linters when saving
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" only run eslint for now
let g:ale_linters = { "javascript": ["eslint"] }
" Navigate linter errors
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

"------------------------------------------------------------------------------
" vim-easymotion
"------------------------------------------------------------------------------
map <M-f> <Plug>(easymotion-bd-f)
map <M-q> <Plug>(easymotion-jumptoanywhere)

"------------------------------------------------------------------------------
" gundo
"------------------------------------------------------------------------------
" Don't use Ex mode, use Q for gundo
nnoremap Q :GundoToggle<CR>

"------------------------------------------------------------------------------
" fzf
"------------------------------------------------------------------------------
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Help call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).' '.join(map(split(globpath(&runtimepath, 'doc'), '\n'), 'fzf#shellescape(v:val)')), 1, <bang>0)

"------------------------------------------------------------------------------
" Ultisnips
"------------------------------------------------------------------------------
if has('win32') || has('win64')
  let $VIMHOME = "~/vimfiles"
else
  let $VIMHOME = "~/.vim"
endif
" Configure UltiSnips dir
let g:UltiSnipsSnippetsDir=$VIMHOME."/UltiSnips"
" Configure UltiSnips keybindings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Set UltiSnips split to vertical
let g:UltiSnipsEditSplit="vertical"

"------------------------------------------------------------------------------
" vim-dirdiff
"------------------------------------------------------------------------------
" Ignore some filetypes
let g:DirDiffExcludes = ".git,*.swp,*.zip,*.exe,*.bak,*.pyc,*.class,*.o,*.obj"

"------------------------------------------------------------------------------
" vim-abolish
"------------------------------------------------------------------------------
" Coerce to snake_case
nnoremap <leader>cs crs
" Coerce to MixedCase
nnoremap <leader>cm crm
" Coerce to camelCase
nnoremap <leader>cc crc
" Coerce to UPPER_CASE
nnoremap <leader>cu cru
" Coerce to dash-case
nnoremap <leader>c- cr-
" Coerce to dot.case
nnoremap <leader>c. cr.
" Coerce to space case
nnoremap <leader>c<space> cr<space>
" Coerce to Title Case
nnoremap <leader>ct crt

"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------
" Toggle NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>
" Show dot files
let NERDTreeShowHidden=1


"------------------------------------------------------------------------------
" vim-polyglot
"------------------------------------------------------------------------------
" Don't use jsx parsers on .js files
let g:jsx_ext_required=1
