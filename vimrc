set number
colorscheme desert
set background=dark
set guifont=Jetbrains_Mono:h11
set encoding=utf8
set autoread
set wildmenu
set ruler
set ignorecase " Ignore case when searching
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
syntax enable " Enable syntax highlighting

" Turn off backup
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set ai " Auto indent
set si " Smart indent
set laststatus=2 " Always show the status line

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c  " Format the status line

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
 
" Remember the last window position
set sessionoptions+=resize,winpos,winsize,buffers,curdir

function! SaveSession()
    let curdir = getcwd()
    let views = winsaveview()
    let session_dir = $HOME . '/vimfiles/session'
    if !isdirectory(session_dir)
        call mkdir(session_dir, "p")
    endif
    execute 'mksession! ' . session_dir . '/Session.vim'
    call writefile([string(views)], session_dir . '/Session.views')
endfunction

function! RestoreSession()
    let session_dir = $HOME . '/vimfiles/session'
    if isdirectory(session_dir)
        let sessionviews = readfile(session_dir . '/Session.views')[0]
        execute 'source ' . session_dir . '/Session.vim'
        execute 'normal! zz'
        execute 'call winrestview('.sessionviews.')'
    endif
endfunction

autocmd VimLeave * call SaveSession()
autocmd VimEnter * call RestoreSession()

