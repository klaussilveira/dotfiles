set t_Co=256
colorscheme base16-ocean
set nocompatible
set number
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set gcr=a:blinkon0
set autoread
set hidden
syntax on
set incsearch
set hlsearch
set viminfo='100,f1
set noswapfile
set nobackup
set mouse=a

if has('persistent_undo')
    set undofile
    set undodir=/tmp
endif

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on
set list listchars=tab:\ \ ,trail:·
set wrap
set nofoldenable

set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugins')
    Plug 'junegunn/fzf', { 'dir': '/var/opt/fzf' }
call plug#end()

" Custom FZF finder
function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

command! -bang ProjectFiles
  \ call fzf#run(fzf#wrap('project-files', {'source': 'git ls-files', 'dir': s:get_git_root()}, <bang>0))

command! -bang FindFiles
  \ execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'ProjectFiles' : 'FZF'

map <c-p> :FindFiles<cr>
