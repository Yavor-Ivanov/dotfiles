scriptencoding utf-8
" Note: Skip initialization for vim-tiny or vim-small.
"
if !1 | finish | endif

" Use tplugin.
runtime bundle/tplugin_vim/macros/tplugin.vim

if has('vim_starting')
	set nocompatible               " Be iMproved

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))


" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'


" Bundles which need to always run on startup.
NeoBundle 'jistr/vim-nerdtree-tabs'				" I'm not sure why this loads faster when loaded first.
NeoBundle 'Shougo/unite.vim'
NeoBundle 'wakatime/vim-wakatime'				" Automatic time tracking for vim with version control integration.
NeoBundle 'kien/ctrlp.vim'						" Fuzzy file search.
NeoBundle 'sickill/vim-monokai'					" Monokai theme.
NeoBundle 'Yavor-Ivanov/airline-monokai-subtle.vim'		" Monokai theme for vim-airline.
NeoBundle 'tpope/vim-fugitive'					" Git wrapper.
NeoBundle 'craigemery/vim-autotag'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'rking/ag.vim'
NeoBundle 'kovisoft/slimv'						" SLiME like environment.
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/vdbi-vim'
NeoBundle 'vim-scripts/quickrun.vim'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'rdnetto/YCM-Generator'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }


" Plugins which are lazy loaded.
TPlugin nerdtree
TPlugin delimitMate
TPlugin vim-commentary
TPlugin vim-easymotion
TPlugin vim-multiple-cursors
TPlugin vim-surround
TPlugin vim-airline
TPlugin PIV
TPlugin vim-git
TPlugin vim-python-pep8-indent
TPlugin vim-bookmarks
TPlugin ctrlp-py-matcher
TPlugin vim-scripts/Comceal.git
TPlugin rainbow
TPlugin vim-bbye
TPlugin vdebug
TPlugin tern_for_vim

"
" Uncomment these lines to install the plugins on first run.
" Note: Comment lines below once the initial install is done to avoid loading these plugins twice.
"
"
" NeoBundle 'tomtom/tplugin_vim'
" NeoBundle 'hynek/vim-python-pep8-indent'		" Python auto indentation rules.
" NeoBundle 'sheerun/vim-polyglot'				" Niceties for all languages.
" NeoBundle 'bling/vim-airline'					" Status bar extension.
" NeoBundle 'vim-airline/vim-airline-themes'					" Status bar extension.
" NeoBundle 'rcabralc/monokai-airline.vim'
" NeoBundle 'terryma/vim-multiple-cursors'		" Sublime-like multiple cursor edit.
" NeoBundle 'scrooloose/nerdtree'				" File system browser.
" NeoBundle 'sjl/gundo.vim'						" Undo buffer window with diffs.
" NeoBundle 'Raimondi/delimitMate'				" Auto close pairs of brackets, quotes, braces.

" NeoBundle 'vim-scripts/TaskList.vim'			" Generates a task list from all TODO and FIXME comments.
" NeoBundle 'junegunn/vim-easy-align'			" Source code alignment.
" NeoBundle 'Lokaltog/vim-easymotion'			" Superior positioning macros.
" NeoBundle 'tpope/vim-commentary'				" One comment keymapping to rule them all.
" NeoBundle 'tpope/vim-surround'
" NeoBundle 'klen/python-mode'					" PEP8, pyflakes, syntax higlighting, mccabe, etc.
" NeoBundle 'tpope/vim-git'						" Vim git integration.
" NeoBundle 'MattesGroeger/vim-bookmarks'
" NeoBundle 'FelikZ/ctrlp-py-matcher'
" NeoBundle 'Shougo/neocomplete.vim'
" NeoBundle 'vim-scripts/Comceal.git'
" NeoBundle 'spf13/PIV'
" NeoBundle 'luochen1990/rainbow'				" Rainbow highlighting for nested parenthesis
" NeoBundle 'bronson/vim-trailing-whitespace'	" Highlights trailing whitespaces in files. Deletes trailing whitespaces on save.
" NeoBundle 'joonty/vdebug.git'					" X-Debug cluent.
" NeoBundle 'moll/vim-bbye'					    " Clear buffer; keep window.
" "
" NeoBundle 'ternjs/tern_for_vim'
call neobundle#end()

" Required:
" If there are uninstalled bundles found on startup
" this will conveniently prompt you to install them.
NeoBundleCheck


" Set plugin preferences. ###########################################
"
" Auto compile coffeescript files on write.
let g:rainbow_active = 1
let g:extra_whitespace_ignored_filetypes = ['unite', 'vimfiler', 'mail']
autocmd BufWritePost *.coffee :CoffeeLint! | cwindow
"
" autocmd BufWritePost *.coffee silent make!
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_expand_jump_to_first_child = 0
let g:DisableAutoPHPFolding = 1
let g:EasyMotion_smartcase = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['\.pyc$']
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
"
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  " set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and
  " respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
let g:php_syntax_extensions_enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'monokai_subtle'
set completeopt-=preview
set ttimeoutlen=50
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" let g:pymode_options_colorcolumn = 120
let g:pymode_options_max_line_length = 120
let g:pymode_lint_options_pep8 = {
	\ 'max_line_length': g:pymode_options_max_line_length,
	\ 'ignore': 'E251'}
let g:pymode_indent = 1
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1 " Use smartcase.
" let g:neocomplete#auto_completion_start_length = 3
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#enable_fuzzy_completion = 1
" let g:neocomplete#data_directory = '~/tmp/.neocomplete'
let g:bufferline_rotate = 1
let g:bufferline_show_bufnr = 0
let g:bufferline_echo = 0
let g:bufferline_inactive_highlight = 'StatusLineNC'
let g:bufferline_active_highlight = 'StatusLine'
let g:bufferline_solo_highlight = 1

let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '' : 'S',
\ }

let g:slimv_swank_cmd = '! screen sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp &'
let g:slimv_repl_split = 0

let g:quickrun_config = {}
let g:quickrun_config.handmade = {
\ 'command' : simplify(getcwd() . '/../build'),
\ 'outputter' : 'quickfix',
\ }

command! ClearQuickfixList cexpr []
function! BuildHandmade()
	:ClearQuickfixList
	:QuickRun handmade
	:copen
endfunction
command! BuildHandmade call BuildHandmade()

" Email options ##########################
function! EmailOptions()
	set wrap
	set linebreak
	set nolist
	set wrapmargin=0
	set textwidth=0
	set expandtab
	setlocal fo+=aw
	7j
endfunction

augroup EmailRules()
  autocmd!
  autocmd FileType mail call EmailOptions()
augroup END


"  Set user preferences. ###################################
set listchars=tab:>-,extends:>,precedes:<
set list
set modelines=5
noremap q <nop>
noremap Q <nop>
set encoding=utf-8
set swapfile
set dir=~/tmp
set keymap=bulgarian-phonetic
set iminsert=0
set imsearch=-1
runtime! ftplugin/man.vim
set nostartofline " Keep the cursor position as is in buffers, please.
set ignorecase
set smartcase
set incsearch
set ttyfast
set lazyredraw
set tags=~/tags
set hidden	 	" Allow new buffers to be opened without being nagged to save the current buffer.
set wildmenu 	" Command completion.
set wildignore=*.swp,*.bak,*.pyc,*.class,*/staticfiles/*,*/build/*
set history=1000
set undolevels=1000
set title
set t_Co=256
colors monokai
set nowrap
set laststatus=2
syntax enable
syntax on
filetype on
filetype plugin on
filetype plugin indent on
set foldmethod=indent
set foldlevel=99
set cc=0
set tabstop=4
set shiftwidth=4
set cindent
let mapleader = "\<Space>"
nmap <leader>l V
map <leader>a ^
map <leader>c :set list!<CR>
map <leader>z g_
nmap <leader>b :BuildHandmade<CR>
set pastetoggle=<F12>
set nonumber
syntax sync minlines=256
set synmaxcol=200
set colorcolumn=80,100


" Saner indenting hotkeys.
nmap <S-Tab> <<
nmap <Tab> >>
vmap <S-Tab> <gv
vmap <Tab> >gv


" Shortcuts to common actions.
nmap <C-s> :w!<CR>
nmap <C-x> :wq!<CR>
nnoremap ; :
vnoremap ; :
nnoremap ! :!<SPACE>
vmap <C-c> "+y
map <C-v> "+p
vmap <C-x> "+d
nmap <leader>p <C-p>
" nnoremap <C-o> <c-v>


" Configure window and buffer navigation shortcuts
set wmw=0
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nmap e :bprev!<CR>
nmap r :bnext!<CR>
map <leader>n :enew!<CR>i
map <leader>x :call CloseWindow()<CR>
map <leader>X :bd!<CR>
map <leader>E :e ~/Development/www/
map <leader>e :e<SPACE>
nmap <leader>w :%s/\s\+$//


" Configure plugin shortcuts #################################
map <leader>td <Plug>TaskList
map <leader>f :NERDTreeTabsOpen<CR>
nmap <leader>s <ESC>:Ag<SPACE>
map <leader>u :GundoToggle<CR>
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" " Neocomplete tab look forward.
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "<TAB>" " Neocomplete tab look backwards.
map f <Plug>(easymotion-s)
map F <Plug>(easymotion-bd-w)

" Configure tab to space commands
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Enable omni completion.
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:phpcomplete_index_composer_command = "composer"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP
:autocmd BufReadPost quickfix nnoremap <buffer> o <CR>


function! CloseWindow()
	if (index(['', 'help', 'qf'], &ft) >= 0)
		:bd
	elseif (&ft == 'nerdtree')
		:NERDTreeTabsClose
	else
		:Bdelete
	endif
endfunction

augroup debugging
    autocmd!
    autocmd FileType qf set nobuflisted
	au! BufRead,BufNewFile,BufEnter Debugger* set nobuflisted | map <buffer> o <CR>
augroup END

autocmd FileType python setlocal nonumber
