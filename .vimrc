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
  " Don't blink the cursor in normal mode
  set guicursor=n:blinkon0
else
  colorscheme noctu
endif

" Set statusline
set statusline=%5l/%-5L
set statusline+=\ col:%3c
set statusline+=\ hex:0x%B
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
noremap + <C-w>+
noremap - <C-w>-

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

" Easier mark jumping
nnoremap ' `
nnoremap ` '

" Strip all trailing whitespace
nnoremap <leader>fW :%s/\s\+$//<CR>:let @/=''<CR>

" Reformat leading tabs/spaces
nnoremap <leader>fw :retab<CR>

" Save files quicker
nnoremap <leader>w :w<CR>

" Save a file as root
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Quit files quicker
nnoremap <leader>q :q<CR>

" Save/quit files quicker
nnoremap <leader>Q :wq<CR>

" change innner word with S
nnoremap S ciw

" Abbreviate file related messges
set shortmess=atAI

" Use system clipboard by default
set clipboard=unnamed,unnamedplus

" Edit vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :source $MYVIMRC<CR>

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

function! SmartInsertTab()
  " Return true if we should insert a tab instead of spaces
  return (!&expandtab) &&
       \ (col('.') == 1 || getline('.')[col('.') - 2] ==? "\<Tab>")
endfunction

function! SmarterTab()
  " force using spaces if there is a non-tab before the cursor
  if SmartInsertTab()
    return "\<Tab>"
  else
    " force it to use spaces
    set expandtab
    return "\<Tab>\<Esc>:set noexpandtab\<CR>a"
  endif
endfunction

function! SmarterIndentOperator(type)
  SmarterIndent("\<C-r>=SmarterTab()\<CR>\<Esc>")
endfunction

function! SmarterUnindentOperator(type)
  SmarterIndent("\<BS>\<Esc>")
endfunction

function! SmarterIndent(indent_op)
  let column = virtcol('.')
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  let visualmode_tab = 0
  let lowest_col = 100
  let visual_range = reverse(range(line("'["), line("']")))
  for l:linenum in visual_range
    silent exe "normal! ".l:linenum."G^"
    if !strlen(getline(l:linenum))
      " skip empty lines
      continue
    endif
    let column = virtcol('.')
    if column < lowest_col
      let lowest_col = column
    endif
  endfor
  for l:linenum in visual_range
    if !strlen(getline(l:linenum))
      " skip empty lines
      continue
    endif
    silent exe "normal! ".l:linenum."G".lowest_col."|i".indent_op
  endfor
  silent exe "normal! I\<Esc>l"

  let &selection = sel_save
  let @@ = reg_save
endfunction

function! StripAlignmentRegex()
  return ":s/^\\(\\t\\+\\)\\ */\\1\\t/\<CR>"
endfunction

function! IndentStripAlignmentInsert()
  " Strip the spaces used for alignment
  " spaces used for alignment
  return "\<C-o>".StripAlignmentRegex()."\<C-o>I"
endfunction

function! IndentStripAlignmentNormal()
  return StripAlignmentRegex()."I\<Esc>l"
endfunction

" We need to map tab in an autocmd after plugins have been loaded,
" since Ultisnips is also mapping tab and will overwrite our mapping
if has('autocmd')
  autocmd VimEnter * imap <expr> <Tab> SmarterTab()
endif

imap <expr> <S-Tab> IndentStripAlignmentInsert()
nmap <expr> <S-Tab> IndentStripAlignmentNormal()
vmap <expr> <S-Tab> IndentStripAlignmentNormal()

nmap > :<C-u>set operatorfunc=SmarterIndentOperator<CR>g@
nmap < :<C-u>set operatorfunc=SmarterUnindentOperator<CR>g@
nmap >> V:<C-u>set operatorfunc=SmarterIndentOperator<CR>g@
nmap << V:<C-u>set operatorfunc=SmarterUnindentOperator<CR>g@
vmap > :<C-u>set operatorfunc=SmarterIndentOperator<CR>gvg@
vmap < :<C-u>set operatorfunc=SmarterUnindentOperator<CR>gvg@

" Use shift-tab to wipe all characters and insert a tab
"imap <S-Tab> <C-\><C-o>0<C-\><C-o>f <C-\><C-o>dw<Tab>
"imap <S-Tab> <C-\><C-o>dT<Tab><Tab>

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
let g:rooter_manual_only = 1 " don't automatically start

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
let g:ale_linters = {
\   "javascript": ["eslint"],
\   "typescript": ["tslint", "tsserver"],
\   "python": ["flake8"],
\}
" Navigate linter errors
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

"------------------------------------------------------------------------------
" vim-easymotion
"------------------------------------------------------------------------------
map <M-f> <Plug>(easymotion-bd-f)
map <M-q> <Plug>(easymotion-jumptoanywhere)
let s:easypaste_yank_key = "y"
let s:easypaste_paste_key = "p"
let s:easypaste_pos = 0
let s:easypaste_prev_opfunc = 0
function! EasyPasteOperator(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:0 " Invoked from Visual mode, use gv command.
        silent exe "normal! gv".s:easypaste_yank_key
    elseif a:type == 'line'
        silent exe "normal! '[V']".s:easypaste_yank_key
    else
        silent exe "normal! `[v`]".s:easypaste_yank_key
    endif

    silent exe "normal! ``".s:easypaste_paste_key

    let &selection = sel_save
    let @@ = reg_save
    echon ""
endfunction
let s:EasyPaste_is_active = 0
function! EasyPasteFinish()
    let s:EasyPaste_is_active = 0
endfunction
function! AttachEasyPasteAutocmd()
    let s:EasyPaste_is_active = 1
    augroup plugin-easypaste-active
        autocmd!
        autocmd InsertEnter,WinLeave,BufLeave <buffer>
            \ call EasyPasteFinish()
            \  | autocmd! plugin-easypaste-active * <buffer>
        autocmd CursorMoved <buffer>
            " Nest autocommand to skip first movement
            \ autocmd plugin-easypaste-active CursorMoved <buffer>
            \ call EasyPasteFinish()
            \  | autocmd! plugin-easypaste-active * <buffer>
    augroup END
endfunction
function! EasyPasteStrip(ind, str)
    return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction
"function! EasyPaste(yank_key, paste_key)
function! EasyPaste(args)
    let s:easypaste_yank_key=get(args, "yank", "y")
    let s:easypaste_paste_key=get(args, "paste", "p")
    let easypaste_func=get(args, "func", "jumptoanywhere")
    let func_raw_str = maparg("<Plug>(easymotion-".easypaste_func.")", "n")
    let matches = matchlist(func_raw_str, '\(EasyMotion#\S\+\)(\(.*\))')
    if len(matches) >= 3
        let func_name = matches[1]
        let func_args_raw = split(matches[2], ",")
        let func_args = map(func_args_raw, function("EasyPasteStrip"))
        call call(func_name, func_args)
    endif
    redraw
    "set s:easypaste_prev_opfunc=&operatorfunc
    set operatorfunc=EasyPasteOperator
    echon "Enter motion:"
    call feedkeys("g@")
endfunction
nnoremap <M-p> :call EasyPaste("y", "p")<CR>
nnoremap <M-P> :call EasyPaste("y", "P")<CR>
nnoremap <M-m> :call EasyPaste("d", "p")<CR>
nnoremap <M-M> :call EasyPaste("d", "P")<CR>

"------------------------------------------------------------------------------
" gundo
"------------------------------------------------------------------------------
" Don't use Ex mode, use Q forgundo
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
nnoremap <leader>s :UltiSnipsEdit<CR>
" Set up asyncomplete
augroup RegisterAsyncompleteUltisnips
    autocmd VimEnter * call asyncomplete#register_source({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ })
augroup end

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
"if executable('typescript-language-server')
"    au User lsp_setup call lsp#register_server({
"      \ 'name': 'typescript-language-server',
"      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'javascript-typescript-stdio --logfile C:\temp\log_tsp.log']},
"      \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
"      \ })
""      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio --tsserver-path=tsserver.cmd']},
""      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
"endif
"let g:lsp_signs_enabled = 1         " enable signs
"let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_warning = {'text': '‼'} " icons require GUI
"let g:lsp_signs_hint = {'text': '✶'} " icons require GUI
