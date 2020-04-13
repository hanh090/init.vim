call plug#begin('~/.vim/plugged')
" Essential
" Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'carlitux/deoplete-ternjs'

" Theme + Style
Plug 'roosta/vim-srcery'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-signify'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ryanoasis/vim-devicons'
" Register list
Plug 'junegunn/vim-peekaboo'

" Support
Plug 'matze/vim-move'
Plug 'easymotion/vim-easymotion'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'alvan/vim-closetag'
Plug 'jremmen/vim-ripgrep'
" Extend matching for html tag
Plug 'tmhedberg/matchit'

"  Git
Plug 'tpope/vim-fugitive'


" Coding style
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['javascript', 'css', 'json', 'scss'] }
Plug 'jiangmiao/auto-pairs'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Code completion, LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Airline for status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

set laststatus=2

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <Esc> :noh<CR><Esc>

"========================================================
" leader config
"========================================================
let mapleader=" "

" NERD tree config
noremap <silent><leader>m :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>

" Searching
noremap <leader>f :FZF<CR>
noremap <leader>a :Ag <CR>
noremap <leader>o :Buffers <CR>
noremap <leader>h :History <CR>
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
nnoremap <C-g> :Rg<Cr>

" Quick saving / edit
noremap <leader>w :w<cr>
noremap <leader>e :e<cr>
noremap <leader>q :q<cr>

" Split screen
noremap <leader>s :vsplit<cr>
noremap <leader>v :split<cr>

" Copy current file / folder path
nnoremap cp :let @* = expand("%")<CR>
nnoremap cP :let @* = expand("%:p")<CR>

" Git
noremap <leader>gu :Gpull<cr>
noremap <leader>gp :Gpush<cr>
noremap <leader>gb :Gblame<cr>

" Easy jump
map  <leader>j <Plug>(easymotion-bd-w)
nmap <leader>j <Plug>(easymotion-overwin-w)

" Custom nerdtree
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeSyntaxEnabledExtensions = ['rb', 'js', 'html', 'haml', 'css', 'erb', 'jsx', 'scss']
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightCursorline = 0

" Custom airline
let g:airline_theme='onedark'
let g:webdevicons_enable_airline_statusline = 1

" Custom closetag
let g:closetag_filenames = '*.js,*.jsx,*.html, *.xml'
" Custom vim-move to use control to move line up/down
let g:move_key_modifier = 'C'

filetype plugin indent on

set clipboard=unnamedplus
set autoindent " Copy indent from current line when starting a new line
set smarttab
set tabstop=2 " Number of space og a <Tab> character
set softtabstop=2
set shiftwidth=2 " Number of spaces use by autoindent
set lazyredraw
set redrawtime=10000
set regexpengine=1
set expandtab

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

set nobackup
set noswapfile
set number
set rnu

set showcmd

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" ==== START COC config
" List coc plugin
let g:coc_global_extensions = ['coc-java', 'coc-json', 'coc-eslint', 'coc-tsserver']

set nowritebackup
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Symbol renaming.
nmap <leader> rn <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" === END COC config

" Auto format
" autocmd BufWritePre * StripWhitespace
" autocmd BufWritePre *.js,*.jsx,*.css,*.scss,*.less Prettier

" Quick escape
inoremap jk <ESC>
inoremap jj <ESC>

" Custom FZF
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden --glob !.git --glob !node_modules'

" Set background and colorscheme
colorscheme solarized8
set background=dark
hi CocUnderlineError cterm=underline ctermfg=61 gui=undercurl guisp=Red
hi link CocErrorHighlight CocUnderlineError
" Required for operations modifying multiple buffers like rename.
set hidden
