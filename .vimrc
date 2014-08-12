set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

let g:Powerline_symbols = 'fancy'
let g:perl_interpreter = '/Users/jan/perl5/perlbrew/perls/perl-5.14.2/bin/perl'
let g:syntastic_perl_lib_path = '/Users/jan/Projekte/rex/lib -I /Users/jan/Projekte/rex-apache-deploy/lib'
let g:syntastic_perl_lib_path .= '-I /Users/jan/Projekte/rex_ioserver/lib'
let g:syntastic_perl_lib_path .= '-I /Users/jan/Projekte/rex_ioweb_ui/lib'
let g:syntastic_perl_lib_path .= '-I /Users/jan/Projekte/rex_ioclient/lib'

set guifont=Source\ Code\ Pro\ for\ Powerline\ 9

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'mileszs/ack.vim'


syn on
" filetype plugin indent on
set autoindent

map <F2> :NERDTreeToggle<CR>
map <F3> :TlistToggle<CR>
map <F8> :TlistAddFilesRecursive .<CR>

map <c-f> :Ack<space>
imap <c-e> <ESC>A
imap <c-a> <ESC>I

set ts=2
set sw=2
set tw=0
set expandtab
set nu

au BufRead,BufNewFile Rexfile           set filetype=perl
au BufRead,BufNewFile *.pp           set filetype=puppet

colorscheme fu
" git branch
set statusline=%f " tail of the filename

"set statusline+=%{fugitive#statusline()}

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        " Always show status line

" warning for mixed indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

if has("gui_running")
   set cursorline
   set cursorcolumn
endif

function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

" return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction
