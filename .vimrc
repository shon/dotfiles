""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"   Shekhar Tiwatne
"   http://flavors.me/shon - pythonic at gmail dot com
"
" Version:
"   0.2
"
" References:
"   Vim as Python IDE: http://www.unlogic.co.uk/posts/vim-python-ide.html
"   80 Columns: http://stackoverflow.com/a/1117367/84513
"   pathogen etc: http://mirnazim.org/writings/vim-plugins-i-use/
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off " why?

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" The bundles you install will be listed here
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'klen/python-mode'
Bundle 'ervandew/taglisttoo'
Bundle 'bling/vim-airline'

filetype plugin indent on

" The rest of your config follows here
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
augroup END

" NerdTree
map <F2> :NERDTreeToggle<CR>

" File type detection
filetype on

" Search
set hlsearch " highlight the search
set ignorecase
set incsearch " incremental (search as you type)

" Use spaces instead of tabs
set expandtab
autocmd FileType make set noexpandtab " not for make files

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set number

" Theme
set background=dark
"colors peaksea

" Tagbar
"let g:tagbar_usearrows = 1
"let g:tagbar_left = 1
"nmap <F8> :TagbarToggle<CR>
"autocmd VimEnter *.py nested :TagbarOpen "https://github.com/majutsushi/tagbar/blob/master/doc/tagbar.txt

" python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" whitespaces
let g:pymode_utils_whitespaces = 1

"Shortcuts

set pastetoggle=<F3> "turn off auto-indent when pasting text

" Remember and restore
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Powerline/airline
set laststatus=2
set t_Co=256 " from airline wiki
" Airline " :help airline
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_paste_symbol = 'Þ'
let g:airline_paste_symbol = '∥'
let g:airline_left_sep = ''

let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_fugitive_prefix = ' '
let g:airline_readonly_symbol = ''



" gvim preferences
if has ('gui_running')
    " set guifont=Droid\ Sans\ Mono\ 11
    set guifont=DejaVu\ Sans\ Mono\ 11
    colorscheme murphy
    " highlight Pmenu guibg=#cccccc gui=bold
endif

" TaglistToo
" https://github.com/ervandew/taglisttoo/blob/master/doc/taglisttoo.txt
let g:Tlist_Auto_Open=1
map <F8> :TlistToo<CR>
" let g:TaglistTooPosition='right'
