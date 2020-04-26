filetype plugin indent on " Enable filetype recognition
syntax enable " Enable syntax highlighting

" Sets
set nocompatible " Enable vi incompatible mode
set number " Enable line numbers
set paste " Allow pasting from clipboard
set incsearch " Enable incremental search (highlight text as you search)
set hlsearch " Highlight matches from previous search
set hidden " Allow switching between files
set wildmode=list:longest " Show all options when navigating and pressing tab

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " Package manager
Plugin 'rust-lang/rust.vim' " Rust
Plugin 'airblade/vim-gitgutter' " Git annotations in editor
Plugin 'preservim/nerdtree' " File tree
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'micha/vim-colors-solarized' " Solarized Theme
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'ctrlpvim/ctrlp.vim' " CTRLP
call vundle#end()

" NERDtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if no window except NERDtree left
let g:NERDTreeDirArrowExpandable = '▸' " Custom expandable sign
let g:NERDTreeDirArrowCollapsible = '▾' " Customize collapsilbe sign
let NERDTreeShowHidden=1 " Show hidden files
map <C-n> :NERDTreeToggle<CR> " Bind NERDtree to CTRL + n

" Rust
let g:rustfmt_autosave = 1 " format upon save

" Theme
colorscheme solarized
set background=dark

" Airline
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

" CTRLP
let g:ctrlp_show_hidden = 1 " Show hidden files

" Gitgutter
set updatetime=250 " Update signs col every 250 ms
nmap <Leader>ga <Plug>(GitGutterStageHunk) " git add (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk) " git undo (chunk)
nmap <Leader>gn <Plug>(GitGutterNextHunk) " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk) " git previous
