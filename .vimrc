""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"   Shekhar Tiwatne
"   http://flavors.me/shon - pythonic at gmail dot com
"
" Version:
"   0.2
"
" References:
"   80 Columns: http://stackoverflow.com/a/1117367/84513
"   pathogen etc: http://mirnazim.org/writings/vim-plugins-i-use/
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number
" File type detection
filetype on

" 80 columns
" Works only on vim > 7.3
"set colorcolumn=80 
"match ErrorMsg /\%>80v.\+/

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

" pathogen initialization
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Theme
set background=dark
"colors peaksea

" Tagbar
let g:tagbar_usearrows = 1
nmap <F8> :TagbarToggle<CR>
autocmd VimEnter *.py nested :TagbarOpen "https://github.com/majutsushi/tagbar/blob/master/doc/tagbar.txt

" Shortcuts
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
