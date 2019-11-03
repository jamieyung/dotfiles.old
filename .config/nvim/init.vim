
" set the leader key
let mapleader = " "

" -----------------------------------------------------------------------------
" -- vim-plug -----------------------------------------------------------------
" -----------------------------------------------------------------------------

" after adding plugins below, install with:
" :source %
" :PlugInstall

call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" indent lines
Plug 'Yggdroot/indentLine'

" Undo tree visual
Plug 'mbbill/undotree'

" Colour schemes
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'

" Better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Language syntax and highlighting
Plug 'sheerun/vim-polyglot'

" Language server support for purescript
Plug 'frigoeu/psc-ide-vim'

" Search
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Multi-file search/replace
Plug 'wincent/ferret'

" File explorer
Plug 'scrooloose/nerdtree'

" Comments
Plug 'tpope/vim-commentary'

" Autocomplete
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'purescript-contrib/purescript-vim'

" Highlights yank
Plug 'machakann/vim-highlightedyank'

" Surround
Plug 'tpope/vim-surround'

" Trailing whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'

" Show number and index of search matches
Plug 'google/vim-searchindex'

call plug#end()

" -----------------------------------------------------------------------------
" -- Plugin config ------------------------------------------------------------
" -----------------------------------------------------------------------------

" NERDTree - Map <C-n> to opening NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" NERDTree - Open NERDTree when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" NERDTree - Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" gitgutter - gitgutter uses the signcolumn to display
set signcolumn=yes

" fzf.vim
nnoremap <leader>f :FZF<CR>
nnoremap <leader>b :Buffers<CR>

" vim-airline
let g:airline#extensions#branch#displayed_head_limit = 10 " truncates branch names to 10

" coc.nvim - Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" coc.nvim - Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" coc.nvim - Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" coc.nvim - Remap for do codeAction of current line
nmap <leader>cf <Plug>(coc-fix-current)

" coc.nvim - Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" coc.nvim - Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc.nvim - Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc.nvim - Close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following indentation
let g:NERDDefaultAlign = 'left'
" Trim trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Set custom delims
let g:NERDCustomDelimiters =
    \ {
    \ 'purescript': { 'left': '-- |', 'right': '' }
    \ }

" -----------------------------------------------------------------------------
" -- Misc ---------------------------------------------------------------------
" -----------------------------------------------------------------------------

" Use <Leader>c for ciw with repeatability
nnoremap <silent> <Leader>c :let @/=expand('<cword>')<cr>cgn

" Run macro over visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Move lines down/up
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Unfold all by default
set foldlevelstart=9

" Meta + direction to move between splits in any mode.
" On Mac, make sure "Use Option as Meta key" is enabled.
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-j> <C-W>j
nnoremap <M-k> <C-W>k
nnoremap <M-h> <C-W>h
nnoremap <M-l> <C-W>l

" Centers screen after the jump
nnoremap <M-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Always enter terminal in insert mode
if has('nvim')
  au BufEnter,BufNew,TermOpen * if &buftype == 'terminal' | :startinsert | endif
endif

" Toggle 'default' terminal
nnoremap <M-t> :call ChooseTerm("term-slider", 1)<CR>
tnoremap <M-t> <C-\><C-N>:call ChooseTerm("term-slider", 1)<CR>
function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider > 0
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
            :exe "botright split"
        endif
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        if a:slider
            :exe "botright split"
        endif
        :terminal
        :exe "f " a:termname
    endif
endfunction

" Close buffer but keep splits
nnoremap <silent> <leader>d :call CloseBuffer()<cr>
function! CloseBuffer()
    let curBuf = bufnr('%')
    let curTab = tabpagenr()
    exe 'bnext'

    " If in last buffer, create empty buffer
    if curBuf == bufnr('%')
        exe 'enew'
    endif

    " Loop through tabs
    for i in range(tabpagenr('$'))
        " Go to tab (is there a way with inactive tabs?)
        exe 'tabnext ' . (i + 1)
        " Store active window nr to restore later
        let curWin = winnr()
        " Loop through windows pointing to buffer
        let winnr = bufwinnr(curBuf)
        while (winnr >= 0)
            " Go to window and switch to next buffer
            exe winnr . 'wincmd w | bnext'
            " Restore active window
            exe curWin . 'wincmd w'
            let winnr = bufwinnr(curBuf)
        endwhile
    endfor

    " Close buffer, restore active tab
    exe 'bd' . curBuf
    exe 'tabnext ' . curTab
endfunction

" relative line numbers in normal mode, absolute line numbers in insert mode
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Autoread fix
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! noautocmd w

" stop space from moving cursor
nnoremap <Space> <Nop>

" live preview of substitute
set inccommand=split

" Map leader esc to exit terminal mode
tnoremap <leader><esc> <c-\><c-n>

" Allow prev/next location jumps in terminal mode
tnoremap <c-o> <c-\><c-o>
tnoremap <c-i> <c-\><c-i>

" leader tv to open terminal in vertical split
nnoremap <leader>tv :vs term://bash<cr>
" leader te to open terminal in current split
nnoremap <leader>te :e term://bash<cr>

" use system clipboard for copy paste
set clipboard=unnamed

" sets cursor back to solid block on exiting vim
au VimLeave * set guicursor=a:block-blinkon0

set hidden

" color scheme
set background=light
colorscheme PaperColor

" set updatetime to 100ms to make gitgutter more responsive
set updatetime=100

" show line numbers
set number

" enable mouse
set mouse=a

" set the command window height to 2 lines
set cmdheight=3

" set encoding to UTF-8
set encoding=utf-8

" visual autocomplete for command menu
set wildmenu

" redraw screen only when need to
set lazyredraw

" highlight matching parens/brackets [{()}]
set showmatch

" always show statusline (even with only a single window)
set laststatus=2

" show line and column number of the cursor on right side of statusline
set ruler

" blink cursor on error instead of beeping
set visualbell

" instead of failing a command because of unsaved changes, raise a dialog
" asking if you wish to save changed files.
set confirm

" maintain undo history between sessions
set undofile

" store undofiles in single directory
set undodir=~/.config/nvim/undodir//

" disable swapfiles
set noswapfile

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" show command in bottom bar
set showcmd

" move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk

" faster write and/or exit
nnoremap <leader>z :wq<CR>
nnoremap <leader>w :w<CR>

" fuzzy search in files
nnoremap <leader>r :Rg<CR>

" make 'Y' yank from cur pos to end of line instead of yanking the whole line
nnoremap Y y$

" paste on newline (eg. yiw will paste on newline)
nnoremap <leader>p :pu<CR>

" use filetype-based syntax highlighting, ftplugins, and indentation
syntax enable
filetype plugin indent on

" indentation settings for using 4 spaces instead of tabs.
" do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" copy indent from current line when starting a new line
set autoindent

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

" turn off search highlighting (using leader cr instead of only cr because
" cr is needed for completion and in other contexts).
nnoremap <leader><CR> :nohlsearch<CR>

" highlight current line
set cursorline

" show whitespace
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
