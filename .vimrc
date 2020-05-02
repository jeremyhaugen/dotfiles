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

" Wrap lines at 79 characters
set textwidth=79

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
  filetype plugin on
endif

" Add :Difforig command to show your changes to the file from the original
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Remove included files from insert mode completion, to prevent pollution
set complete-=i

" Always show status line
set laststatus=2

if &encoding ==# 'latin1' && has('gui_running')
  " Use utf-8 encoding
  set encoding=utf-8
endif

" Display some whitespace characters
set list
if has('gui_running')
    set listchars=tab:▸\ ,trail:·,extends:→,precedes:←,nbsp:˽
    set showbreak=╚
else
    set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:+
    set showbreak=^
endif

" Toggle whitespace characters
noremap <leader>vw :set list!<CR>

" Remove comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Don't break already long lines in insert mode
set formatoptions+=l

" Don't automatically break long code lines
set formatoptions-=t

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
    " Configure quickscope colors
    augroup qs_colors
      autocmd!
      autocmd ColorScheme * highlight QuickScopePrimary guifg='#87d7ff' gui=underline ctermfg=117 cterm=underline
      autocmd ColorScheme * highlight QuickScopeSecondary guifg='#d7afd7' gui=underline ctermfg=182 cterm=underline
    augroup END

    " Map fzf colors to the colorscheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
    colorscheme iceberg
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
  " Don't blink the cursor in normal mode
  set guicursor=n:blinkon0
else
  colorscheme noctu
endif

" Set statusline
set statusline=%5l/%-5L
set statusline+=\ col:%3v
set statusline+=\ hex:0x%B
set statusline+=\ %=%{pathshorten(expand('%:f'))}%m%r
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
noremap + <C-w>+
noremap - <C-w>-

" Open current file directory
nnoremap <leader>d :Explore<CR>

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

" Navigate the jumplist by files
function! JumpToNextBufferInJumplist(dir) " 1=forward, -1=backward
    let jl = getjumplist() | let jumplist = jl[0] | let curjump = jl[1]
    let jumpcmdstr = a:dir > 0 ? "<C-I>" : "<C-O>"
    let jumpcmdchr = a:dir > 0 ? "\<C-I>" : "\<C-O>"    " <C-I> or <C-O>
    let searchrange = a:dir > 0 ? range(curjump+1,len(jumplist))
                              \ : range(curjump-1,0,-1)
    for i in searchrange
        if jumplist[i]["bufnr"] != bufnr('%')
            let n = (i - curjump) * a:dir
            echo "Executing ".jumpcmdstr." ".n." times."
            execute "silent normal! ".n.jumpcmdchr
            break
        endif
    endfor
endfunction
nnoremap <M-o> :call JumpToNextBufferInJumplist(-1)<CR>
nnoremap <M-i> :call JumpToNextBufferInJumplist(1)<CR>

" Maintain column for various commands
set nostartofline

" Confirm when trying to quit with unsaved changes
set confirm

" Show hybrid line numbers
set number
set relativenumber

" Highlight the cursor line
set cursorline

" Make Y behave more similar to other shift commands (D, C, etc.)
nnoremap Y y$

" Enable perl/python regex when searching
nnoremap / /\v
vnoremap / /\v

" Easier mark jumping
nnoremap ' `
nnoremap ` '

" Strip all trailing whitespace
nnoremap <leader>mW :%s/\s\+$//<CR>:let @/=''<CR>

" Reformat leading tabs/spaces
nnoremap <leader>mw :retab<CR>

" Save files quicker
nnoremap <leader>w :w<CR>

" Save a file as root
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Quit files quicker
nnoremap <leader>q :q<CR>

" Save/quit files quicker
nnoremap <leader>Q :wq<CR>

" Don't use Ex mode. Instead run a quick macro.
nnoremap Q @q

" change innner word with S
nnoremap S ciw

" Abbreviate file related messges
set shortmess=atAI

" Use system clipboard by default
set clipboard=unnamed,unnamedplus

" Edit vimrc file
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vr :source $MYVIMRC<CR>

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

"------------------------------------------------------------------------------
" Tab/space related settings
"------------------------------------------------------------------------------

" Set file specific tab settings
if has('autocmd')
  autocmd Filetype * setlocal ts=4 sts=4 sw=4 expandtab
  autocmd Filetype xml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype python setlocal ts=4 sts=4 sw=4 noexpandtab
endif

" Copy indent from current line when starting a new line
set autoindent

" Copy the indent structure from current line when starting a new line
set copyindent

" Round indent to multiple of shiftwidth when using '<' or '>'
set shiftround

function! Interleave()
    " retrieve last selected area position and size
    let start = line(".")
    execute "normal! gvo\<esc>"
    let end = line(".")
    let [start, end] = sort([start, end], "n")
    let size = (end - start + 1) / 2
    " and interleave!
    for i in range(size - 1)
        execute (start + size + i). 'm' .(start + 2 * i)
    endfor
endfunction

" Select your two contiguous, same-sized blocks, and use it to Interleave
vnoremap <leader>z <esc>:call Interleave()<CR>

"==============================================================================
" Plugin Configuration
"==============================================================================

"------------------------------------------------------------------------------
" netrw
"------------------------------------------------------------------------------
" Use tree view for netrw
let g:netrw_liststyle = 0
" Remove the top banner
let g:netrw_banner = 0
" Hide '.' and '..' directories in netrw
let g:netrw_list_hide = '^\./$,^\../$'
" Obey the g:netrw_list_hide variable
let g:netrw_hide = 1

" Ability to non-empty directories
function! s:rmdir()
  if input('delete '.fnamemodify(bufname(''),':p').getline('.').' ? (y/n)') ==# 'y'
    if !delete(fnamemodify(bufname(''),':p').getline('.'),'rf')
      if search('^\.\/$','Wb')
        exe "norm \<cr>"
      endif
    endif
  endif
endfunction
command! Rmnetrw call <SID>rmdir()

" Set netrw specific keybindings
" augroup netrw_mapping
"   autocmd!
"   autocmd filetype netrw call NetrwMapping()
" augroup END
" 
" function! NetrwMapping()
"   noremap <buffer> <leader>d :Rmnetrw<CR>
" endfunction

"------------------------------------------------------------------------------
" vim-rooter
"------------------------------------------------------------------------------
let g:rooter_use_lcd = 1 " set each dir local to the window
let g:rooter_resolve_links = 1 " resolve symbolic links
let g:rooter_manual_only = 1 " don't automatically start
let g:root_switching_enabled = 1

" Switch to root based on directory name
let g:valid_roots = [
  \ "PythonApplications", "Source", fnamemodify($HOME, ":t"), "dotfiles",
  \ "vimfiles", "dev", "sandbox"]

function! ChangeDirectory(dir)
  if a:dir !=# getcwd()
    execute ":lcd" fnameescape(a:dir)
  endif
endfunction

function! SetRoot()
  if !g:root_switching_enabled
    return
  endif
  let l:root_dir = getbufvar("%", "localRootDir")
  if !empty(l:root_dir)
    call ChangeDirectory(l:root_dir)
    return
  endif
  let l:cur_file = resolve(expand("%:p"))
  if empty(l:cur_file)
    return
  endif
  let l:file_dir = isdirectory(l:cur_file) ? l:cur_file : fnamemodify(l:cur_file, ":h")
  let l:prev_dir = ""
  while 1
    let l:dir_name = fnamemodify(l:file_dir, ":t")
    for l:valid_dir in g:valid_roots
      if l:valid_dir == l:dir_name
        call ChangeDirectory(l:file_dir)
        call setbufvar("%", "localRootDir", l:file_dir)
        return
      endif
    endfor
    let l:prev_dir = l:file_dir
    let l:file_dir = fnamemodify(l:file_dir, ":h")
    if l:prev_dir == l:file_dir
      " We reached the top. Use vim-rooter instead.
      execute ":Rooter"
      return
    endif
  endwhile
endfunction

augroup findRoot
  autocmd!
  autocmd VimEnter,BufEnter * nested if empty(&buftype) | call SetRoot() | endif
  autocmd BufWritePost * nested if empty(&buftype) | call setbufvar("%", "localRootDir", "") | call SetRoot() | endif
augroup END

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
let g:ale_echo_msg_format = "[%linter%][%code%] %s [%severity%]"
" only run linters when saving
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" only run eslint for now
let g:ale_linters = {
\   "javascript": ["eslint"],
\   "typescript": ["tslint", "tsserver"],
\   "python": ["pylint"],
\}
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
nnoremap <leader>vu :GundoToggle<CR>

"------------------------------------------------------------------------------
" fzf
"------------------------------------------------------------------------------
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Help call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).' '.join(map(split(globpath(&runtimepath, 'doc'), '\n'), 'fzf#shellescape(v:val)')), 1, <bang>0)

command! -bang -nargs=* VimHelp call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).' '.$VIM, 1, <bang>0)




" Case sensitive ripgrep
command! -bang -nargs=* Rgs call fzf#vim#grep('rg --column --line-number --no-heading --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" Add ctrl-q binding to add to quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'}

" Set ripgrep as default grep
set grepprg=rg\ --vimgrep

nnoremap <leader>vh :VimHelp<CR>
nnoremap <leader>vH :Help
nnoremap <leader>f :GFiles --exclude-standard --cached --others<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>: :Commands<CR>
nnoremap <leader>r :Rgs<space>
nnoremap <leader>R :Rg<space>
nnoremap <leader>8 :Rgs <C-R><C-W><CR>
nnoremap <leader>* :Rg <C-R><C-W><CR>
vnoremap <leader>8 y:Rgs <C-R>"<CR>
vnoremap <leader>* y:Rg <C-R>"<CR>

nmap <silent> <leader>gd :LspDefinition<CR>
nmap <silent> <leader>gy :LspTypeDefinition<CR>
nmap <silent> <leader>gi :LspImplementation<CR>
nmap <silent> <leader>gr :LspReferences<CR>
nmap <silent> <leader>gj :LspNextReference<CR>
nmap <silent> <leader>gk :LspPreviousReference<CR>
nmap <silent> <leader>ga :LspCodeAction<CR>

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
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:ultisnips_python_format="google"
" Set UltiSnips split to vertical
let g:UltiSnipsEditSplit="vertical"
nnoremap <leader>s :UltiSnipsEdit<CR>

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
nnoremap <leader>z :NERDTreeToggle<CR>
" Show dot files
let NERDTreeShowHidden=1

"------------------------------------------------------------------------------
" vim-polyglot
"------------------------------------------------------------------------------
" Don't use jsx parsers on .js files
let g:jsx_ext_required=1

"------------------------------------------------------------------------------
" vim-encode
"------------------------------------------------------------------------------
let g:vim_encode_default_mapping=0
" type <leader>\" to escape the " string
nnoremap <leader>\ @=encode#begin('cstring')<CR>i
vnoremap <leader>\ @=encode#begin('cstring')<CR>
nnoremap <leader>& @=encode#begin('html')<CR>i
vnoremap <leader>& @=encode#begin('html')<CR>
nnoremap <leader>% @=encode#begin('url')<CR>i
vnoremap <leader>% @=encode#begin('url')<CR>
nnoremap <leader># @=encode#begin('hex')<CR>i
vnoremap <leader># @=encode#begin('hex')<CR>

"------------------------------------------------------------------------------
" vim-lsp
"------------------------------------------------------------------------------
let g:lsp_diagnostics_enabled = 0
if executable('pyls')
  au User lsp_setup call lsp#register_server({
  \ 'name': 'pyls',
  \ 'cmd': {server_info->['pyls']},
  \ 'whitelist': ['python'],
  \ })
endif