" ============================================
" functions
" ============================================
function! IsWindows()
    if (has("win32") || has("win64"))
        return 1
    else
        return 0
    fi
endfunction

function! ConfigVundle()
    call BeforeVundle()
    call DoVundle()
    call AfterVundle()
endfunction

function! BeforeVundle()
    set nocompatible
    filetype off
    if (IsWindows())
        set rtp+=$VIM/vimfiles/bundle/vundle/
        call vundle#rc('$VIM/vimfiles/bundle/')
    else
        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()
    endif
endfunction
function! DoVundle()
    Bundle 'gmarik/vundle'

    Bundle 'a.vim'
    Bundle 'blackboard.vim'
    Bundle 'kien/ctrlp.vim'
    Bundle 'minibufexpl.vim'
    Bundle 'orestis/pysmell'
    Bundle 'pep8'
    Bundle 'pydoc.vim'
    Bundle 'pyflakes.vim'
    Bundle 'rails.vim'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/syntastic'
    Bundle 'taglist.vim'
    Bundle 'Valloric/ListToggle'
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'ZenCoding.vim'
endfunction
function! AfterVundle()
    filetype plugin indent on
endfunction

function! ConfigVimEdit()
    set autoindent
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set expandtab
    set smarttab
    autocmd FileType ruby,eruby,yaml set shiftwidth=2 | set softtabstop=2 |
                                   \ set tabstop=2 | set expandtab |
                                   \ set smarttab
    set wrap
    set ignorecase smartcase
    set backspace=indent,eol,start
endfunction

function! ConfigVimEncoding()
    set encoding=utf-8
    set fileencodings=utf-8,gb2312,gbk,gb18030
    set termencoding=utf-8
    if (IsWindows())
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        "set langmenu=zh_CN.UTF-8
        language messages zh_CN.utf-8
    endif
endfunction

function! ConfigVimHighlight()
    set cursorline
    set hlsearch
endfunction

function! ConfigVimSearch()
    set incsearch
endfunction

function! ConfigVimStatusBar()
    "set ruler " Always show current positions along the bottom
    "set rulerformat=%57(%50t[%{&ff},%Y]\ %m\ %l,%c\ %p%%%) "ruler format.
    set laststatus=2
    set statusline=\ %F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]
                  \\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]
                  \[%p%%]\ [LEN=%L]
endfunction

function! SaveSession()
    if (filereadable("session.vim"))
        execute 'mksession! session.vim'
        :wviminfo viminfo
    endif
endfunction

function! LoadSession()
    if (filereadable("session.vim"))
        if (filereadable("viminfo"))
            :rviminfo viminfo
        endif
        silent! execute 'source session.vim'
        redraw!
    endif
endfunction

function! ForceSaveSession()
    execute 'mksession! session.vim'
    redraw!
endfunction

function! ConfigVimSession()
    set sessionoptions=
    set sessionoptions+=sesdir,slash,unix,resize,winpos,buffers,folds,help
    autocmd VimEnter * call LoadSession()
    autocmd VimLeave * call SaveSession()
    map <silent> <leader>ss :call ForceSaveSession()<CR>
endfunction

function! ConfigVimOther()
    syntax on
    set guioptions-=m
    set history=1000
    set ignorecase smartcase
    set mouse=a
    set nobackup
    set number
    set paste
    set wrap
    set cc=81
endfunction

function! ConfigVimBell()
    set noerrorbells
    set novisualbell
    set vb t_vb=
    autocmd GuiEnter * set t_vb=
endfunction

function! ConfigVimPrint()
    if (!IsWindows())
        "set printdevice=iP1880-series "printer, use system printer if not
        set printencoding=utf-8 "encoding of printing. use encoding if not set.
        "charset of print. should be compatible with printencoding.
        set printmbcharset=ISO10646
        "set printmbfont=r:MSungGBK-Light,c:yes
        "打印所用字体, 在linux下,要用ghostscript里已有的字体, 不然会打印乱码.
        set printmbfont=r:STSong-Light,c:yes
        "打印可选项, formfeed: 是否处理换页符, header: 页眉大小,
        " paper:"用何种纸, duplex: 是否双面打印, syntax: 是否支持语法高
        set printoptions=formfeed:y,paper:A4,duplex:on,syntax:y",header:3
        "set printheader=%<%f%h%m%=Page\ %N "打印时页眉的格式
    endif
endfunction

function! ConfigVimListChar()
    " 非可见字符
    set listchars=tab:>-,trail:-,extends:>,precedes:< " display tab
    set list
endfunction

function! ConfigVimFold()
    set foldmethod=indent
    set foldlevel=99
endfunction

function! ConfigVimColorScheme()
    colorscheme blackboard
endfunction

function! ConfigVimLeader()
    "let mapleader = ","
    let g:mapleader = ","
endfunction

function! ConfigVimrc()
    map <silent> <leader>lv :source $HOME/.vimrc<cr>
    map <silent> <leader>ev :e $HOME/.vimrc<cr>
endfunction

function! ConfigVimShortcut()
    if has("gui_running")
        map <M-w> :bd<CR>
    else
        map <Esc>w :bd<CR>
    endif
endfunction

function! BeforeVim()
    call ConfigVimLeader()
    if (IsWindows())
        source $VIMRUNTIME/vimrc_example.vim
        source $VIMRUNTIME/mswin.vim
        behave mswin
    endif
endfunction

function! DoVim()
    call ConfigVimBell()
    call ConfigVimColorScheme()
    call ConfigVimEdit()
    call ConfigVimEncoding()
    call ConfigVimFold()
    call ConfigVimHighlight()
    call ConfigVimListChar()
    call ConfigVimOther()
    call ConfigVimrc()
    call ConfigVimSearch()
    call ConfigVimSession()
    call ConfigVimShortcut()
    call ConfigVimStatusBar()
endfunction

function! AfterVim()
endfunction

function! ConfigVim()
    call BeforeVim()
    call DoVim()
    call AfterVim()
endfunction

function! ConfigPluginYouCompleteMe()
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_min_num_of_chars_for_completion = 1
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    if has("gui_running")
        map <M-z> :YcmCompleter GoToDefinitionElseDeclaration<CR>
    else
        map <Esc>z :YcmCompleter GoToDefinitionElseDeclaration<CR>
    endif
endfunction

function! ConfigPluginCtrlP()
    let g:ctrlp_working_path_mode = 0
    map <silent> <leader>t :CtrlP<cr>
    map <silent> <leader>T :CtrlPClearCache<cr> :CtrlP<cr>
    if has("gui_running")
        map <M-t> :CtrlP<CR>
        map <M-T> :CtrlPClearCache<CR> :CtrlP<CR>
    else
        map <Esc>t :CtrlP<CR>
        map <Esc>T :CtrlPClearCache<CR> :CtrlP<CR>
    endif
endfunction

function! ConfigPluginA()
    if has("gui_running")
        map <M-a> :A<CR>
    else
        map <Esc>a :A<CR>
    endif
endfunction

function! ConfigPluginMinibufExp()
    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplTabWrap = 1
endfunction

function! ConfigPluginNerdTree()
    let g:NERDTreeWinPos = "left"
    nmap <F6> <ESC>:NERDTreeToggle<RETURN>
endfunction

function! ConfigPluginNerdCommenter()
    if has("gui_running")
        map <M-c> <leader>c<space><CR>
    else
        map <Esc>c <leader>c<space><CR>
    endif
endfunction

function! ConfigPluginTaglist()
    let g:Tlist_Show_One_File = 1
    let g:Tlist_Exit_OnlyWindow = 1
    let g:Tlist_Use_Right_Window = 1
    let g:Tlist_Sort_Type = "name"
    let g:Tlist_GainFocus_On_ToggleOpen = 1
    map <silent> <F8> :TlistToggle<cr>
endfunction

function! ConfigPluginPython()
    " pep8
    let g:pep8_map='<leader>8'

    " pydoc settings for pydoc.vim to find pydoc command in windows
    if (IsWindows())
        let g:pydoc_cmd = 'C:\Python25\Lib\pydoc.py'
    endif

    " pyflakes
    let g:pyflakes_use_quickfix = 0

    " pysmell
    "autocmd FileType python setlocal omnifunc=pysmell#Complete
endfunction

function! ConfigPluginRuby()
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails = 1
    map <silent> <leader>rc :Rcontroller 
    map <silent> <leader>rf :Rfind 
    map <silent> <leader>rg :Rgenerate 
    map <silent> <leader>rj :Rjavascript 
    map <silent> <leader>rm :Rmodel 
    map <silent> <leader>rss :Rserver<CR>
    map <silent> <leader>rsr :Rserver!<CR>
    map <silent> <leader>rv :Rview 
endfunction

function! ConfigPluginZenCoding()
    map <silent> <leader>zz :call zencoding#expandAbbr(3, "")<CR>
    map <silent> <leader>zc :call zencoding#toggleComment()<CR>
    map <silent> <leader>zn :call zencoding#moveNextPrev(0)<CR>
    map <silent> <leader>zN :call zencoding#moveNextPrev(1)<CR>
endfunction

function! BeforePlugin()
endfunction

function! DoPlugin()
    call ConfigPluginA()
    call ConfigPluginCtrlP()
    call ConfigPluginMinibufExp()
    call ConfigPluginNerdTree()
    call ConfigPluginNerdCommenter()
    call ConfigPluginPython()
    call ConfigPluginRuby()
    call ConfigPluginTaglist()
    call ConfigPluginYouCompleteMe()
    call ConfigPluginZenCoding()
endfunction

function! AfterPlugin()
endfunction

function! ConfigPlugin()
    call BeforePlugin()
    call DoPlugin()
    call AfterPlugin()
endfunction

" ============================================
" config
" ============================================
call ConfigVundle()
call ConfigVim()
call ConfigPlugin()
