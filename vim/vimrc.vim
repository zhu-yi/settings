"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                    " Don't be compatible with the old vi
filetype off                        " Mandatory for Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jlanzarotta/bufexplorer'
"Plugin 'wesleyche/SrcExpl'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vivien/vim-linux-coding-style'
Plugin 'embear/vim-localvimrc'
Plugin 'altercation/vim-colors-solarized'
Plugin 'lervag/vimtex'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'gregsexton/gitv'
"Plugin 'wincent/command-t'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'kergoth/vim-bitbake'
"Plugin 'ludovicchabant/vim-gutentags'
"Plugin 'skywind3000/gutentags_plus'
"Plugin 'skywind3000/vim-preview'
"Plugin 'ronakg/quickr-preview.vim'
call vundle#end()
filetype plugin indent on

set runtimepath+=$HOME/Projects/github/settings/vim
set spellfile=$HOME/Projects/github/settings/vim/spell/en.latin1.add

""""""""""""""
" :h solarized
""""""""""""""
syntax on
set t_Co=256
"set t_Co=16
set listchars=tab:>-,trail:^,nbsp:%,space:.

let g:solarized_termcolors = 256
let g:solarized_visibility = "normal"
let g:solarized_hitrail    = 0

"set background=light
set background=dark
colorscheme solarized

""""""""
" :h Man
""""""""
runtime ftplugin/man.vim
nmap K :Man <cword><cr>


""""""""""""""""
" :h bufexplorer
""""""""""""""""
let g:bufExplorerDisableDefaultKeyMapping = 1
let g:bufExplorerDetailedHelp             = 1
let g:bufExplorerShowDirectories          = 0
let g:bufExplorerSortBy                   = 'fullpath'
let g:bufExplorerSplitOutPathName         = 0

""""""""""""""""""""""""""""""""
" vim-cpp-enhanced-highlight.vim
""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight                  = 1
let g:cpp_member_variable_highlight              = 1
let g:cpp_class_decl_highlight                   = 1
let g:cpp_experimental_simple_template_highlight = 1
autocmd BufRead */include/* setfiletype cpp

""""""""""
" :h netrw
""""""""""
let g:netrw_banner       = 1
let g:netrw_browse_split = 0
let g:netrw_liststyle    = 1
"let g:netrw_keepdir      = 0
"let g:netrw_list_hide    = '.lvimrc,.ycm_extra_conf.py,.ycm_extra_conf.pyc,GPATH,GRTAGS,GTAGS,gtags.files,tags'
"let g:netrw_hide         = 1

"""""""""""""""
" :h localvimrc
"""""""""""""""
let g:localvimrc_sandbox = 0

"""""""""""
" :h tagbar
"""""""""""
let g:tagbar_sort        = 0
let g:tagbar_autoshowtag = 1

""""""""""""""""
" :h srcexpl
""""""""""""""""
let g:SrcExpl_winHeight       = 8
let g:SrcExpl_refreshTime     = 100
let g:SrcExpl_jumpKey         = "<ENTER>"
let g:SrcExpl_gobackKey       = "<SPACE>"
let g:SrcExpl_pluginList      = ["__Tagbar__", "Source_Explorer"]
let g:SrcExpl_searchLocalDef  = 1
let g:SrcExpl_isUpdateTags    = 0
"let g:SrcExpl_updateTagsKey   = "<F12>"
"let g:SrcExpl_prevDefKey      = "<F3>"
"let g:SrcExpl_nextDefKey      = "F4"

""""""""""""""""
" :h command-t
""""""""""""""""
let g:CommandTMaxHeight = 30
let g:CommandTMaxFiles  = 500000
let g:CommandTInputDebounce = 50
let g:CommandTFleScanner = 'watchman'
let g:CommandTMaxCachedDirectories = 10
let g:CommandTSmartCase = 1
let g:CommandTMatchWindowAtTop = 1
let g:CommandTMatchWindowReverse = 0
let g:CommandTCancelMap = ['<esc>', '<c-x>']

""""""""""""""""""""""
" :h youcompleteme
""""""""""""""""""""""
let g:ycm_min_num_of_chars_for_completion     = 4
let g:ycm_complete_in_comments                = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax        = 1
let g:ycm_server_use_vim_stdout               = 0
let g:ycm_confirm_extra_conf                  = 1

let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_semantic_triggers = {'c,cpp,python':['re!\w{2}']}

let g:ycm_auto_hover = 'CursorHold'
augroup YcmHoverCustom
	autocmd!
	autocmd FileType c,cpp let b:ycm_hover = {
	\ 'command': 'GetDoc',
	\ 'syntax': &filetype
	\ }
augroup END

function! s:CustomizeYcmQuickFixWindow()
	" Set the window height to 5.
	5wincmd _
endfunction

autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()

"let g:ycm_cache_omnifunc                      = 0

"let g:ycm_server_keep_logfiles                = 1
"let g:ycm_server_log_level                    = 'debug'

"""""""""""""""""
" :h fugitive.txt
"""""""""""""""""
autocmd BufReadPost fugitive://* set bufhidden=delete

let g:Gitv_OpenHorizontal = 0

""""""""""""""""""
" gtags-cscope.vim
""""""""""""""""""
"let g:GtagsCscope_Auto_Load		= 0
"let g:GtagsCscope_Auto_Map		= 0
"let g:GtagsCscope_Use_Old_Key_Map	= 0

let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_project_root = ['.root']
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_generate_on_write = 0
"let g:gutentags_plus_switch = 1

"nmap p <plug>(quickr_preview)
"nmap q <plug>(quickr_preview_qf_close)

let g:quickr_preview_position = 'right'
let g:quickr_preview_on_cursor = 1
let g:quickr_preview_exit_on_enter = 1

""""""""""""""""""""""
" :h vimtex-tex-flavor
""""""""""""""""""""""
let g:tex_flavor = 'latex'

" :h airline
""""""""""""
"let g:airline_solarized_bg = 'light'
let g:airline_solarized_bg = 'dark'
let g:airline_theme = 'solarized'
let g:airline#extensions#quickfix#quickfix_text  = 'Quickfix'
let g:airline#extensions#quickfix#location_text  = 'Location'
let g:airline#extensions#tagbar#enabled          = 1
let g:airline#extensions#whitespace#enabled      = 0
"let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#formatter       = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"""""""""""""
" :h tmuxline
"""""""""""""
let g:tmuxline_preset = {
\'a'    : '#S',
\'win'  : ['#I', '#W'],
\'cwin' : ['#I', '#W', '#F'],
\'x'    : '%R',
\'y'    : '%a',
\'z'    : '%F'
\}

let g:ctab_enable_default_filetype_maps=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set autoindent
set smartindent
set smarttab                        " Be smart when using tabs
set autoread                        " Auto read when file changed outside
set splitright                      " Vertical split place at right
set switchbuf=usetab,useopen        " Jump to file if existing
set number                          " Show line number
set backspace=indent,eol,start      " Configure backspace
set clipboard+=unnamedplus,unnamed  " Share clipboard with system
set completeopt=menu,menuone        " Close preview window
set formatoptions=tcroqnj           " See :h formatoptions
set hlsearch                        " Highlight search results
set incsearch                       " Show result while type
set ignorecase                      " Ignore case when searching
set smartcase                       " Smart about cases when searching
set history=1000                    " History number
set lazyredraw                      " Don't redraw while executing macros
set hidden                          " Buffer becomes hidden when abandoned
set magic                           " For regular expressions turn magic on
set showmatch                       " Show matching brackets
set textwidth=80                    " Set the length of a line
set wrapmargin=2                    " Set the margin of a line
set colorcolumn+=1                  " Highlight column after text width
set mouse=a                         " Enable mouse in all mode
set linebreak                       " Wrap lines at a character in 'breakat'
set showcmd                         " Show partial command in the last line
set showmode                        " Show current mode in the last line
set wildmode=longest,list,full      " Let tab complete as much as possible
set wildmenu                        " Completion with menu
set nowrap                          " Don't wrap lines
set noswapfile                      " No swap file
set nobackup                        " No backup file
set wildignore=*.so,*.o,*.pyc,*~    " Ignored files
set encoding=utf-8                  " Character encoding used inside VIM
set foldmethod=syntax               " Use language syntax for folding
set foldlevel=100                   " Fold level
set foldcolumn=5                    " Columns for display fold
set guicursor+=a:blinkon0           " Disable cursor blinking
set updatetime=250                  " Fast update time for gitgutter
set spell spelllang=en_us           " Enable spell check

set pastetoggle=<F7>
set pumheight=10                    " Used by YouCompleteMe
set regexpengine=0                  " Automatic select regexp engine

"set autochdir                       " Auto change to directory of current file
"autocmd BufEnter * silent! lcd %:p:h
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Custom key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

function! LineNumberToggle()
	if(&relativenumber == 1)
		set number
		set norelativenumber
	else
		set nonumber
		set relativenumber
	endif
endfunc

nnoremap <leader><leader> :nohlsearch<cr>
nnoremap <leader>jd       :YcmCompleter GoTo<cr>
nnoremap <leader>jr       :YcmCompleter GoToReferences<cr>
nnoremap <leader>ji       :YcmCompleter GoToInclude<cr>
nnoremap <leader>se       :SrcExplToggle<cr>
nnoremap <leader>tb       :TagbarToggle<cr>
nnoremap <leader>bx       :bp\|bd #<cr>
nnoremap <leader>bt       :ToggleBufExplorer<cr>
nnoremap <leader>ln       :call LineNumberToggle()<cr>

nnoremap <leader>r        :%s/\<<c-r><c-w>\>//gc<left><left><left>
nnoremap <leader>f        :Ggrep! <cword> <cr>:cw<cr>
nnoremap <leader>n        :cnext<cr>
nnoremap <leader>p        :cprev<cr>
nnoremap <leader>q        :cclose<cr>

nmap <leader>1            <Plug>AirlineSelectTab1
nmap <leader>2            <Plug>AirlineSelectTab2
nmap <leader>3            <Plug>AirlineSelectTab3
nmap <leader>4            <Plug>AirlineSelectTab4
nmap <leader>5            <Plug>AirlineSelectTab5
nmap <leader>6            <Plug>AirlineSelectTab6
nmap <leader>7            <Plug>AirlineSelectTab7
nmap <leader>8            <Plug>AirlineSelectTab8
nmap <leader>9            <Plug>AirlineSelectTab9
nmap <leader>'            <Plug>AirlineSelectPrevTab
nmap <leader>;            <Plug>AirlineSelectNextTab

nmap <silent> <c-t>       <Plug>(CommandT)
nmap <silent> <c-b>       <Plug>(CommandTBuffer)
nmap <silent> <c-j>       <Plug>(CommandTJump)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Custom project settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:linuxsty_patterns = [
\ "/home/yi/Projects/github/linux",
\ ]
