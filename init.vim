" Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

" Editing
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set textwidth=150

" Clipboard
set clipboard=unnamed

" Searching
set hls
set inccommand=split

" Show invisible characters
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" Full-width character
set ambiwidth=double

" Command to read init.vim
command! SourceInit source $XDG_CONFIG_HOME/nvim/init.vim

" Buffer settings
set hidden

" If cursor is before right bracket and <TAB> is pushed, cursor is moved right.
function! s:tab_ignoreparen()
  if matchstr(getline('.'), '.', col('.')-1, 1) =~ '[\)\}\]\>]'
    return "\<RIGHT>"
  else
    return "\<TAB>"
  endif
endfunction

" If cursor is before right bracket and the same right bracket is pushed, cursor is moved right.
function! s:paren_aug(paren)
  let s:nextchar = matchstr(getline('.'), '.', col('.')-1, 1)
  if s:nextchar =~ '[\)\}\]\>]' && s:nextchar == a:paren
    return "\<RIGHT>"
  else
    return a:paren
  endif
endfunction

" key mapping
nnoremap ; :
nnoremap : ;
nnoremap gj j
nnoremap gk k
nnoremap j gj
nnoremap k gk
nnoremap <silent> <C-k> :<C-u>bn<CR>
nnoremap <silent> <C-j> :<C-u>bp<CR>
nnoremap <silent> <C-h> 0
nnoremap <silent> <C-l> $
nnoremap <silent> <F3> :<C-u>noh<CR>
vnoremap <silent> <C-h> 0
vnoremap <silent> <C-l> $
vnoremap <silent> jk <ESC>
inoremap <silent> jj <ESC>:<C-u>w<CR>
inoremap <silent> jk <ESC>
inoremap <silent> ( ()<LEFT>
inoremap <silent> { {}<LEFT>
inoremap <silent> [ []<LEFT>
inoremap <silent> < <><LEFT>
inoremap <silent> {<CR> {}<LEFT><CR><ESC><S-o><TAB>
inoremap <silent> <expr> <TAB> <SID>tab_ignoreparen()
inoremap <silent> <expr> ) <SID>paren_aug(')')
inoremap <silent> <expr> } <SID>paren_aug('}')
inoremap <silent> <expr> ] <SID>paren_aug(']')
inoremap <silent> <expr> > <SID>paren_aug('>')

"==================
" dein.vim setting
"==================
" If you does not use dein.vim, comment out the following.
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" add directory of dein to runtimepath
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, 'p:')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.config/nvim/rc/')
  let s:toml      = g:rc_dir . 'dein.toml'
  let s:lazy_toml = g:rc_dir . 'dein_lazy.toml'
  
  call dein#load_toml(s:toml,      {'lazy':0})
  call dein#load_toml(s:lazy_toml, {'lazy':1})

  call dein#end()
  call dein#save_state()
endif

" If plugins does not exist, install them.
if dein#check_install()
  call dein#install()
endif

