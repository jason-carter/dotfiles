set nocompatible
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

"
" ^^ Everything before is default
" vv Everything after is mine
"

call pathogen#infect()

"" Back-ups
set nobackup		" don't backup before overwriting a file (these would be left after writing)
set nowritebackup	" don't backup before overwriting a file (these would be removed after writing)
set noswapfile		" trying vim without swap files to assess performance impact...

"" Whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<		" whitespace display chars
set linebreak		" wrap long lines at a 'breakat'

"" Searching
set ignorecase		" case insensitive searches
set incsearch		" search as characters are entered
"set hlsearch		" highlight matches

"" Encryption
set cm=blowfish		" securer vim encryption with blowfish

let g:GPGPreferArmor=1	" GPG setting (better than vim's encryption?) for using ascii armour
let g:GPGDefaultRecipients=["jjcarter@me.com"]

"" Look n feel
set guifont=Consolas:h10
set number		" show line numbers in the gutter
set cursorline		" highlight the current row
"set cursorcolumn	" highlight the current column
set lines=50		" open main window 50 chars long
set columns=120		" open main window 120 chars wide
set background=light	" use light backgrounds
set nofoldenable	" don't like code folding
"set colorcolumn=85	" add a coloured line at column 85 to indicate if a line is too long
"set synmaxcol=120	" highlighting for first 120 columns only - a performance tweak
set tabstop=8		" number of visual spaces per TAB
set softtabstop=8	" number of spaces in tab when editing
"set expandtab		" tabs are spaces
set lazyredraw		" redraw only when need to
set showmatch		" highlight matching [{()}]

"" Status bar
set laststatus=2	"so that the status line will appear with only one window
set statusline=%<%F%m%r%h%w%y\ %{&ff}%=\ pos:%l,%c\ (%L\ lines)\ %p%%
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

"" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

"" Automatically reload vimrc when it's saved (doesn't seem to work so disabled)
"au BufWritePost .vimrc so C:/Program Files/Vim/_vimrc

"" Map file extensions from one typ to another
au BufRead,BufNewFile *.arena set filetype=xml

"" Press x to automatically pretty print xml files
nmap <leader>x <Esc>:set filetype=xml<CR>:%s/></>\r</g<CR><ESC>gg=G<Esc>:noh<CR>


" turn-on distraction free writing mode for markdown files
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} call FocusModeOn()

"" FocusMode

function! FocusModeOn()
	set laststatus=0
	set numberwidth=10
	set foldcolumn=12
	set noruler
	set nonumber
	hi FoldColumn ctermbg=none
	hi LineNr ctermfg=0 ctermbg=none
	hi NonText ctermfg=0
	set guioptions-=r			" remove right scrollbar
	set guioptions-=m			" remove menu bar
	set guioptions-=T			" remove toolbar
	set lines=999 columns=999
	"set fuoptions=background:#00f5f6f6	" macvim specific setting for editor's background color
	"set fullscreen				" macvim specific go to fullscreen editing mode
endfunc

function! FocusModeOff()
	set laststatus=2
	set numberwidth=4
	set foldcolumn=0
	set ruler
	set number
	set guioptions+=r			" add right scrollbar
	set guioptions+=m			" add menu bar
	set guioptions+=T			" add toolbar
	set lines=50 columns=120
	"execute 'colorscheme ' . g:colors_name
endfunc

function! ToggleFocusMode()
	if (&foldcolumn != 12)
		call FocusModeOn()
	else
		call FocusModeOff()
	endif
endfunc

nnoremap <F1> :call ToggleFocusMode()<cr>


"" GUI Specific settings
if has('gui_win32')

	color darkblue
	set linespace=1 " reset this for now - changed to 5 as part of iawriter

elseif has('gui_macvim')

	" Switch OSX windows with swipes
	nnoremap <silent> <SwipeLeft> :macaction _cycleWindowsBackwards:<CR>
	nnoremap <silent> <SwipeRight> :macaction _cycleWindows:<CR>

	color MacVim
endif

