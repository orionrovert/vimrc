"""
" FOR LINUX SYSTEMS
"""
" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"""
" FOR WINDOWS SYSTEMS
"""
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"""
" End of OS Customizations
"""

" Necesary  for lots of cool vim things
set nocompatible

" The bottom line in your editor will show you information about the current command going on
set showcmd

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Setup special case matching rules when searching
set hlsearch            			" Highlight search results
set ignorecase					" Do case insensitive matching
set smartcase					" Only do case-sensitive searching when the search string contains uppercase letter
set incsearch					" Start search as string is entered
nnoremap <cr> :noh<CR><CR>:<backspace>		" Have Enter clear all highlighted matches


" Allow movement between buffers without saving, and confirm all changes when exiting
set hidden
set confirm

" Set tabs as 4 spaces and retab entire document
:set tabstop=4
:set shiftwidth=4
:set expandtab
:retab

" Use automatic indentation
set cindent

" Set editor view options
syntax on                       " Turn on syntax highlighting
set number
set showmatch			" Show matching brackets

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monaco\ Italic\ 9
    "set guifont=Inconsolata\ Italic\ 9
  elseif has("gui_win32")
    "set guifont=Inconsolata:h13:cANSI:b
    set guifont=Monaco:h11:cANSI
  endif
endif


" Cleanup pesky backup files VIM likes to create
set nobackup
set nowritebackup
set noswapfile

" Remove Toolbar
set guioptions-=T

" Do a recursive search to find top-level ctags file
set tags=./tags;/
" :!ctags -R .

" Taglist options
let Tlist_Use_Right_Window= 1

"Toggle TagList on and off using F3
nnoremap <silent> <F3> :TlistToggle<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Make jj the easy way to get into Normal Mode
inoremap jj <Esc>

" Maintain search results in the middle of the screen
map N Nzz
map n nzz

" Use J and K to keep the cursor in the center of the screen when scrolling through a file.
map K kzz
map J jzz

" Map keys for copy and paste
map <C-c> "+y<CR>
map <C-v> "+gP<CR>

" In UNIX...
" Map the Increase/Decrease font sizes to keys
"map <M-Up> :LargerFont<CR>
"map <M-Down> :SmallerFont<CR>

" In Windows
" Map the Increase/Decrease font sizes to keys
nmap <M-Down> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <M-Up> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

"Get access to the shell by pressing F5
map <F5> <Esc>:!

" Remap wq to close all files in window (a true exit of vim)
:ca wq wqa

" Cool tab completion stuff
set wildmode=list:longest,full
set wildmenu

let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "twilight#obsidian2#desert#wombat#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction

" Once a theme is selected, place it here
set background=dark
colors solarized

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Previous Buffer
map <silent> <M-Left> :bprevious<CR>

" Next Buffer
map <silent> <M-Right> :bnext<CR>

" Next Tab
nnoremap <silent> <M-S-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <M-S-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <M-n> :tabnew<CR>

" Rotate Color Scheme <F8>
"nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" Open the Project Plugin <F2>
nnoremap <silent> <F2> :Project<CR>

" At least let yourself know what mode you're in
set showmode




"""
" Not sure what this does yet, but leave it in for now...
"""
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif
"
" OR
"
" Get that filetype stuff happening
" filetype on
" filetype plugin on
" filetype indent on


"""
" Comment out the folding stuff for now, maybe use it in the future...
"""
" Folding Stuffs
"set foldmethod=marker

" vim plugins in use
" TagList
" Indexer
" Project
" vim-fuzzyfinder
"
" Dependencies
" L9
" vimprj
" dfrank util (?)
