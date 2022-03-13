" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set exrc
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set incsearch
set termguicolors
set smartcase
set magic
set scrolloff=9
set nobackup
set nowritebackup
set noshowmode
set signcolumn=yes
set cmdheight=2
set updatetime=50
set shortmess+=c

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'sonph/onehalf', {'rtp':'vim'}
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'jalvesaq/Nvim-r'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'
Plug 'preservim/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'Valloric/YouCompleteMe'

if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'weirongxu/coc-explorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Local Leader Key
let mapleader = ' '
let g:mapleader = ' '

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>v :wincmd v<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>s :wincmd s<CR>
nnoremap <leader>c :wincmd q<CR>

" nmap <leader>e <Cmd>CocCommand explorer<CR>

" Plugin Settings

" FZF
nnoremap <leader>ff :FZF~<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>bb :Buffers<CR>
" NCM2
set completeopt=noinsert,menuone,noselect
"let g:ycm_language_server = [{'name':'r', 'filetypes': ['r'], 'cmdline': ['usr/bin/R', '--slave','-e','languageserver::run()']}]

"Nerd Tree
map <leader>nn :NERDTreeToggle<CR>

" Lightline
set laststatus=2

" Mouse Integration
set mouse=i

" Tabs and Navigation
map <leader>nt :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>tn :tabn<cr>
map <leader>tp :tabp<cr>

" Colors & Fonts
syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:lightline={'colorscheme':'onehalfdark'}
set encoding=utf-8
highlight Normal ctermbg=NONE
autocmd BufEnter * :highlight Normal ctermbg=NONE ctermfg = NONE

" Return to last position when reopening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" set window size when opening
set lines=70 columns=1000

