let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
cnoremap <nowait> <t_�k>l <Right>
cnoremap <nowait> <t_�k>h <Left>
inoremap <silent> <SNR>79_AutoPairsReturn =AutoPairsReturn()
inoremap <silent> <SNR>43_AutoPairsReturn =AutoPairsReturn()
inoremap <expr> <Plug>(fzf-complete-word) fzf#vim#complete#word()
inoremap <expr> <Plug>(fzf-complete-path) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -print | sed '1d;s:^..::'")
inoremap <expr> <Plug>(fzf-complete-file) fzf#vim#complete#path("find . -path '*/\.*' -prune -o -type f -print -o -type l -print | sed 's:^..::'")
inoremap <expr> <Plug>(fzf-complete-file-ag) fzf#vim#complete#path('ag -l -g ""')
inoremap <expr> <Plug>(fzf-complete-line) fzf#vim#complete#line()
inoremap <expr> <Plug>(fzf-complete-buffer-line) fzf#vim#complete#buffer_line()
inoremap <silent> <Plug>(fzf-maps-i) :call fzf#vim#maps('i', 0)
inoremap <silent> <Plug>(matchup-c_g%) :call matchup#motion#insert_mode()
imap <silent> <C-G>% <Plug>(matchup-c_g%)
inoremap <C-U> u
inoremap <C-W> u
inoremap <M-K> :m .-2==gi
inoremap <M-J> :m .+1==gi
nmap  [%
nnoremap <silent>  :nohlsearch=has('diff')?'|diffupdate':''
nnoremap l :wincmd l
nnoremap k :wincmd k
nnoremap j :wincmd j
nnoremap h :wincmd h
nmap <silent> % <Plug>(matchup-%)
xmap <silent> % <Plug>(matchup-%)
omap <silent> % <Ignore><Plug>(matchup-%)
nnoremap // :Rg
nnoremap <t_�k>h :wincmd h
nnoremap <t_�k>j :wincmd j
nnoremap <t_�k>k :wincmd k
nnoremap <t_�k>l :wincmd l
nnoremap ?? :Files
inoremap Ë :m .-2==gi
inoremap Ê :m .+1==gi
nmap Q <Nop>
nnoremap ZQ :q!
nnoremap ZT :tabclose
omap [- <Plug>(IndentWisePreviousLesserIndent)
xmap [- <Plug>(IndentWisePreviousLesserIndent)
nmap [- <Plug>(IndentWisePreviousLesserIndent)
omap [= <Plug>(IndentWisePreviousEqualIndent)
xmap [= <Plug>(IndentWisePreviousEqualIndent)
nmap [= <Plug>(IndentWisePreviousEqualIndent)
omap [+ <Plug>(IndentWisePreviousGreaterIndent)
xmap [+ <Plug>(IndentWisePreviousGreaterIndent)
nmap [+ <Plug>(IndentWisePreviousGreaterIndent)
omap [_ <Plug>(IndentWisePreviousAbsoluteIndent)
xmap [_ <Plug>(IndentWisePreviousAbsoluteIndent)
nmap [_ <Plug>(IndentWisePreviousAbsoluteIndent)
omap [% <Plug>(IndentWiseBlockScopeBoundaryBegin)
xmap [% <Plug>(IndentWiseBlockScopeBoundaryBegin)
nmap [% <Plug>(IndentWiseBlockScopeBoundaryBegin)
map [t :tabprevious
map [C :call Ctoggle()
map [c :cprevious
map <silent> [w :wincmd h
map <silent> [b :bprevious
nnoremap [[ :bprevious
nnoremap \K :call dist#man#PreGetPage(0)
nnoremap <silent> \\ :WhichKey '\' '\'
nnoremap <silent> \ :WhichKey '\'
nnoremap \\k :Maps
nnoremap \\h :Helptags
nnoremap \\g :Rg
nnoremap \\f :Files
nnoremap \\c :Commands
nnoremap <silent> \a :call SourceLuafile()
nnoremap <silent> \q :Bclose
nnoremap \  :b#
nmap \Q :%bd|e#
omap ]- <Plug>(IndentWiseNextLesserIndent)
xmap ]- <Plug>(IndentWiseNextLesserIndent)
nmap ]- <Plug>(IndentWiseNextLesserIndent)
omap ]= <Plug>(IndentWiseNextEqualIndent)
xmap ]= <Plug>(IndentWiseNextEqualIndent)
nmap ]= <Plug>(IndentWiseNextEqualIndent)
omap ]+ <Plug>(IndentWiseNextGreaterIndent)
xmap ]+ <Plug>(IndentWiseNextGreaterIndent)
nmap ]+ <Plug>(IndentWiseNextGreaterIndent)
omap ]_ <Plug>(IndentWiseNextAbsoluteIndent)
xmap ]_ <Plug>(IndentWiseNextAbsoluteIndent)
nmap ]_ <Plug>(IndentWiseNextAbsoluteIndent)
omap ]% <Plug>(IndentWiseBlockScopeBoundaryEnd)
xmap ]% <Plug>(IndentWiseBlockScopeBoundaryEnd)
nmap ]% <Plug>(IndentWiseBlockScopeBoundaryEnd)
nnoremap <silent> ] :WhichKey ']'
map ]t :tabnext
map ]C :call Ctoggle()
map ]c :cnext
map <silent> ]w :wincmd l
map <silent> ]b :bnext
nnoremap ]] :bnext
xmap <silent> a% <Plug>(matchup-a%)
omap <silent> a% <Plug>(matchup-a%)
nmap cr <Plug>(abolish-coerce-word)
nmap gx <Plug>(open-word-under-cursor)
xmap gx <Plug>(open-word-under-cursor)
xmap gc <Plug>Commentary
nmap gc <Plug>Commentary
omap gc <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap gcu <Plug>Commentary<Plug>Commentary
nmap <silent> g% <Plug>(matchup-g%)
xmap <silent> g% <Plug>(matchup-g%)
omap <silent> g% <Ignore><Plug>(matchup-g%)
nmap gs <Plug>(SwitchInLine)
xmap <silent> i% <Plug>(matchup-i%)
omap <silent> i% <Plug>(matchup-i%)
nmap qQ <Cmd>NERDTreeFind
nmap qq <Cmd>NERDTreeToggle
nmap q <Nop>
nmap <silent> z% <Plug>(matchup-z%)
xmap <silent> z% <Plug>(matchup-z%)
omap <silent> z% <Plug>(matchup-z%)
nnoremap <t_�k>l :wincmd l
nnoremap <t_�k>k :wincmd k
nnoremap <t_�k>j :wincmd j
nnoremap <t_�k>h :wincmd h
xnoremap <silent> <SNR>34_(matchup-Z%) :call matchup#motion#jump_inside_prev(1)
xnoremap <silent> <SNR>34_(matchup-z%) :call matchup#motion#jump_inside(1)
xnoremap <silent> <SNR>34_(matchup-[%) :call matchup#motion#find_unmatched(1, 0)
xnoremap <silent> <SNR>34_(matchup-]%) :call matchup#motion#find_unmatched(1, 1)
xnoremap <silent> <SNR>34_(matchup-g%) :call matchup#motion#find_matching_pair(1, 0)
xnoremap <silent> <SNR>34_(matchup-%) :call matchup#motion#find_matching_pair(1, 1)
nnoremap <silent> <expr> <SNR>34_(wise) empty(g:v_motion_force) ? 'v' : g:v_motion_force
nnoremap <Plug>(open-word-under-cursor) <ScriptCmd>vim9.Open(GetWordUnderCursor())
xnoremap <Plug>(open-word-under-cursor) <ScriptCmd>vim9.Open(getregion(getpos('v'), getpos('.'), { type: mode() })->join())
nnoremap <silent> <Plug>(fzf-insert) i
nnoremap <silent> <Plug>(fzf-normal) <Nop>
tnoremap <silent> <Plug>(fzf-insert) i
tnoremap <silent> <Plug>(fzf-normal) 
nnoremap <silent> <Plug>(fzf-maps-n) :call fzf#vim#maps('n', 0)
xnoremap <silent> <Plug>(fzf-maps-x) :call fzf#vim#maps('x', 0)
onoremap <silent> <Plug>(fzf-maps-o) :call fzf#vim#maps('o', 0)
nnoremap <silent> <expr> <Plug>(Switch) execute("set opfunc=switch#OpfuncForward").'g@l'
nnoremap <silent> <expr> <Plug>(SwitchReverse) execute("set opfunc=switch#OpfuncReverse").'g@l'
nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"
nnoremap <silent> <Plug>(matchup-hi-surround) :call matchup#matchparen#highlight_surrounding()
nnoremap <silent> <expr> <SNR>88_(wise) empty(g:v_motion_force) ? 'v' : g:v_motion_force
nnoremap <silent> <Plug>(matchup-%) <Cmd>call matchup#motion#find_matching_pair(0, 1)
nnoremap <silent> <Plug>(matchup-g%) <Cmd>call matchup#motion#find_matching_pair(0, 0)
xnoremap <silent> <SNR>88_(matchup-%) :call matchup#motion#find_matching_pair(1, 1)
onoremap <silent> <Plug>(matchup-%) :call matchup#motion#op('%')
xnoremap <silent> <SNR>88_(matchup-g%) :call matchup#motion#find_matching_pair(1, 0)
onoremap <silent> <Plug>(matchup-g%) :call matchup#motion#op('g%')
nnoremap <silent> <Plug>(matchup-]%) <Cmd>call matchup#motion#find_unmatched(0, 1)
nnoremap <silent> <Plug>(matchup-[%) <Cmd>call matchup#motion#find_unmatched(0, 0)
xnoremap <silent> <SNR>88_(matchup-]%) :call matchup#motion#find_unmatched(1, 1)
xnoremap <silent> <SNR>88_(matchup-[%) :call matchup#motion#find_unmatched(1, 0)
onoremap <silent> <Plug>(matchup-]%) :call matchup#motion#op(']%')
onoremap <silent> <Plug>(matchup-[%) :call matchup#motion#op('[%')
nnoremap <silent> <Plug>(matchup-z%) <Cmd>call matchup#motion#jump_inside(0)
xnoremap <silent> <SNR>88_(matchup-z%) :call matchup#motion#jump_inside(1)
onoremap <silent> <Plug>(matchup-z%) :call matchup#motion#op('z%')
nnoremap <silent> <Plug>(matchup-Z%) <Cmd>call matchup#motion#jump_inside_prev(0)
xnoremap <silent> <SNR>88_(matchup-Z%) :call matchup#motion#jump_inside_prev(1)
onoremap <silent> <Plug>(matchup-Z%) :call matchup#motion#op('Z%')
xnoremap <silent> <Plug>(matchup-i%) :call matchup#text_obj#delimited(1, 1, 'delim_all')
xnoremap <silent> <Plug>(matchup-a%) :call matchup#text_obj#delimited(0, 1, 'delim_all')
onoremap <silent> <Plug>(matchup-i%) :call matchup#text_obj#delimited(1, 0, 'delim_all')
onoremap <silent> <Plug>(matchup-a%) :call matchup#text_obj#delimited(0, 0, 'delim_all')
nnoremap <silent> <Plug>(matchup-double-click) :call matchup#text_obj#double_click()
nnoremap <Plug>(matchup-reload) :MatchupReload
nmap <silent> <2-LeftMouse> <Plug>(matchup-double-click)
nnoremap <silent> <C-L> :nohlsearch=has('diff')?'|diffupdate':''
nnoremap <Plug>ManPreGetPage :call dist#man#PreGetPage(0)
nnoremap <silent> <Plug>(SwitchInLine) :call SwitchLine(v:count1)
nnoremap <F5> :source $XDG_CONFIG_HOME/vim/vimrc
vnoremap <M-K> :m '<-2gv=gv
vnoremap <M-J> :m '>+1gv=gv
nnoremap <M-J> :m .+1==
nnoremap <M-K> :m .-2==
nmap <C-K> [%
nmap <M-q> :Bclose
nnoremap <silent> <Plug>(Save) :silent write
imap <silent> % <Plug>(matchup-c_g%)
inoremap  u
inoremap  u
cnoremap <nowait> l <Right>
cnoremap <nowait> h <Left>
cnoremap <nowait> <t_�k>h <Left>
cnoremap <nowait> <t_�k>l <Right>
vnoremap Ë :m '<-2gv=gv
vnoremap Ê :m '>+1gv=gv
nnoremap Ê :m .+1==
nnoremap Ë :m .-2==
nmap ñ :Bclose
let &cpo=s:cpo_save
unlet s:cpo_save
set autoread
set autowriteall
set background=dark
set clipboard=unnamedplus
set cmdheight=2
set complete=.,w,b,u,t
set completeopt=menu,menuone,noselect
set display=lastline,truncate
set fileencodings=ucs-bom,utf-8,default,latin1
set formatoptions=croqlj
set guioptions=agimrLtT
set helplang=en
set hidden
set ignorecase
set incsearch
set langnoremap
set nolangremap
set laststatus=2
set lazyredraw
set lisp
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set mouse=a
set mousefocus
set nrformats=bin,hex
set packpath=/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir,~/.config/vim,/nix/store/lkv187jl4yb74dnw65ka7xrk2cmf6jsr-vim-full-9.2.0106/share/vim/vimfiles,/nix/store/lkv187jl4yb74dnw65ka7xrk2cmf6jsr-vim-full-9.2.0106/share/vim/vim92,/nix/store/lkv187jl4yb74dnw65ka7xrk2cmf6jsr-vim-full-9.2.0106/share/vim/vimfiles/after,~/.config/vim/after
set runtimepath=/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-which-key,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-sensible,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-matchup,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-lastplace,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-indentwise,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-highlightedyank,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-devicons,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-cool,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-commentary,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-auto-save,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-airline,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-abolish,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/tabular,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/switch.vim,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/nerdtree,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/gruvbox-material,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/fzf.vim,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/fzf,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/direnv.vim,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/bclose.vim,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/auto-pairs,~/.config/vim,/nix/store/lkv187jl4yb74dnw65ka7xrk2cmf6jsr-vim-full-9.2.0106/share/vim/vimfiles,/nix/store/lkv187jl4yb74dnw65ka7xrk2cmf6jsr-vim-full-9.2.0106/share/vim/vim92,/nix/store/lkv187jl4yb74dnw65ka7xrk2cmf6jsr-vim-full-9.2.0106/share/vim/vim92/pack/dist/opt/netrw,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/vim-matchup/after,/nix/store/kgk3y2lbvglciv6i4cs3i82fpjavbn68-vim-pack-dir/pack/home-manager/start/tabular/after,/nix/store/lkv187jl4yb74dnw65ka7xrk2cmf6jsr-vim-full-9.2.0106/share/vim/vimfiles/after,~/.config/vim/after
set scrolloff=8
set sessionoptions=buffers,curdir,folds,help,tabpages,options,winpos,winsize
set noshowmode
set showtabline=2
set sidescroll=1
set sidescrolloff=2
set smarttab
set splitbelow
set splitkeep=topline
set statusline=%F%F%F%F%F%F%F
set noswapfile
set tabline=%!airline#extensions#tabline#get()
set tabpagemax=50
set tags=./tags;,./TAGS,tags,TAGS
set termguicolors
set timeoutlen=500
set title
set titlestring=\ %{expand('%:p')}\\
set ttimeout
set ttimeoutlen=100
set undodir=~/.local/state/vim/undo/
set undofile
set updatetime=400
set viewoptions=folds,cursor,curdir
set viminfo=!,'100,<50,s10,h
set viminfofile=~/.config/vim/viminfo
set wildignorecase
set wildmode=noselect:lastused,full
set wildoptions=pum
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
doautoall SessionLoadPre
silent only
silent tabonly
cd /etc/nixos
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess+=aoO
badd +21 lua/vimrc
argglobal
%argdel
edit lua/vimrc
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 70 + 106) / 212)
exe 'vert 2resize ' . ((&columns * 70 + 106) / 212)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 212)
argglobal
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <M-(> =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> <M-)> =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> <M-[> =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> <M-]> =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> <M-{> =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> <M-}> =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> <M-"> =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> <M-'> =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
inoremap <buffer> <silent> <C-H> =AutoPairsDelete()
inoremap <buffer> <silent> <M-e> =AutoPairsFastWrap()
inoremap <buffer> <silent> <expr> <M-p> AutoPairsToggle()
inoremap <buffer> <silent> <M-n> :call AutoPairsJump()a
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> î :call AutoPairsJump()a
noremap <buffer> <silent> <M-p> :call AutoPairsToggle()
noremap <buffer> <silent> <M-n> :call AutoPairsJump()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
noremap <buffer> <silent> ð :call AutoPairsToggle()
noremap <buffer> <silent> î :call AutoPairsJump()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=unload
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"\\\ ,:\"
setlocal commentstring=\"%s
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeopt=
setlocal concealcursor=
set conceallevel=2
setlocal conceallevel=2
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=\\v^\\s*export\\s*(def|const|var|final)
setlocal dictionary=
setlocal nodiff
setlocal diffanchors=
setlocal equalprg=
setlocal errorformat=
setlocal eventignorewin=
setlocal noexpandtab
if &filetype != 'vim'
setlocal filetype=vim
endif
setlocal fillchars=
setlocal findfunc=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=croqlj
setlocal formatprg=
setlocal grepformat=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=\\v^\\s*import\\s*(autoload)?
setlocal includeexpr=
setlocal indentexpr=g:VimIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=endif,=enddef,=endfu,=endfor,=endwh,=endtry,=endclass,=endinterface,=endenum,=},=else,=cat,=finall,=END,0\\,0=\"\\\ ,0=#\\\ 
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,#
setlocal keywordprg=:VimKeywordPrg
setlocal lhistory=10
setlocal nolinebreak
setlocal lisp
setlocal lispoptions=
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=vimcomplete#Complete
setlocal path=.,,,pack/**,runtime/**,autoload/**,colors/**,compiler/**,ftplugin/**,indent/**,keymap/**,macros/**,plugin/**,syntax/**,after/**
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=8
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
set signcolumn=yes
setlocal signcolumn=yes
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=%!airline#statusline(1)
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'vim'
setlocal syntax=vim
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=78
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixbuf
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal winhighlight=
set nowrap
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 8 - ((7 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
normal! 040|
wincmd w
argglobal
if bufexists(fnamemodify("lua/vimrc", ":p")) | buffer lua/vimrc | else | edit lua/vimrc | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <M-(> =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> <M-)> =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> <M-[> =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> <M-]> =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> <M-{> =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> <M-}> =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> <M-"> =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> <M-'> =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
inoremap <buffer> <silent> <C-H> =AutoPairsDelete()
inoremap <buffer> <silent> <M-e> =AutoPairsFastWrap()
inoremap <buffer> <silent> <expr> <M-p> AutoPairsToggle()
inoremap <buffer> <silent> <M-n> :call AutoPairsJump()a
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> î :call AutoPairsJump()a
noremap <buffer> <silent> <M-p> :call AutoPairsToggle()
noremap <buffer> <silent> <M-n> :call AutoPairsJump()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
noremap <buffer> <silent> ð :call AutoPairsToggle()
noremap <buffer> <silent> î :call AutoPairsJump()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=unload
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"\\\ ,:\"
setlocal commentstring=\"%s
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeopt=
setlocal concealcursor=
set conceallevel=2
setlocal conceallevel=2
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=\\v^\\s*export\\s*(def|const|var|final)
setlocal dictionary=
setlocal nodiff
setlocal diffanchors=
setlocal equalprg=
setlocal errorformat=
setlocal eventignorewin=
setlocal noexpandtab
if &filetype != 'vim'
setlocal filetype=vim
endif
setlocal fillchars=
setlocal findfunc=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=croqlj
setlocal formatprg=
setlocal grepformat=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=\\v^\\s*import\\s*(autoload)?
setlocal includeexpr=
setlocal indentexpr=g:VimIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=endif,=enddef,=endfu,=endfor,=endwh,=endtry,=endclass,=endinterface,=endenum,=},=else,=cat,=finall,=END,0\\,0=\"\\\ ,0=#\\\ 
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,#
setlocal keywordprg=:VimKeywordPrg
setlocal lhistory=10
setlocal nolinebreak
setlocal lisp
setlocal lispoptions=
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=vimcomplete#Complete
setlocal path=.,,,pack/**,runtime/**,autoload/**,colors/**,compiler/**,ftplugin/**,indent/**,keymap/**,macros/**,plugin/**,syntax/**,after/**
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=8
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
set signcolumn=yes
setlocal signcolumn=yes
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=%!airline#statusline(2)
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'vim'
setlocal syntax=vim
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=78
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixbuf
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal winhighlight=
set nowrap
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 8 - ((7 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
normal! 0
wincmd w
argglobal
enew | setl bt=help
help airline@en
balt lua/vimrc
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <M-n> :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> <M-p> AutoPairsToggle()
inoremap <buffer> <silent> <M-e> =AutoPairsFastWrap()
inoremap <buffer> <silent> <C-H> =AutoPairsDelete()
inoremap <buffer> <silent> <BS> =AutoPairsDelete()
inoremap <buffer> <silent> <M-'> =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> <M-"> =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> <M-}> =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> <M-{> =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> <M-]> =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> <M-[> =AutoPairsMoveCharacter('[')
inoremap <buffer> <silent> <M-)> =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> <M-(> =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> § =AutoPairsMoveCharacter('''')
inoremap <buffer> <silent> ¢ =AutoPairsMoveCharacter('"')
inoremap <buffer> <silent> © =AutoPairsMoveCharacter(')')
inoremap <buffer> <silent> ¨ =AutoPairsMoveCharacter('(')
inoremap <buffer> <silent> î :call AutoPairsJump()a
inoremap <buffer> <silent> <expr> ð AutoPairsToggle()
inoremap <buffer> <silent> å =AutoPairsFastWrap()
inoremap <buffer> <silent> ý =AutoPairsMoveCharacter('}')
inoremap <buffer> <silent> û =AutoPairsMoveCharacter('{')
inoremap <buffer> <silent> Ý =AutoPairsMoveCharacter(']')
inoremap <buffer> <silent> Û =AutoPairsMoveCharacter('[')
noremap <buffer> <silent> <M-n> :call AutoPairsJump()
noremap <buffer> <silent> <M-p> :call AutoPairsToggle()
inoremap <buffer> <silent>  =AutoPairsDelete()
inoremap <buffer> <silent>   =AutoPairsSpace()
inoremap <buffer> <silent> " =AutoPairsInsert('"')
inoremap <buffer> <silent> ' =AutoPairsInsert('''')
inoremap <buffer> <silent> ( =AutoPairsInsert('(')
inoremap <buffer> <silent> ) =AutoPairsInsert(')')
noremap <buffer> <silent> î :call AutoPairsJump()
noremap <buffer> <silent> ð :call AutoPairsToggle()
inoremap <buffer> <silent> [ =AutoPairsInsert('[')
inoremap <buffer> <silent> ] =AutoPairsInsert(']')
inoremap <buffer> <silent> ` =AutoPairsInsert('`')
inoremap <buffer> <silent> { =AutoPairsInsert('{')
inoremap <buffer> <silent> } =AutoPairsInsert('}')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal backupcopy=
setlocal balloonexpr=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=unload
setlocal nobuflisted
setlocal buftype=help
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=
setlocal commentstring=
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeopt=
setlocal concealcursor=nc
set conceallevel=2
setlocal conceallevel=2
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal diffanchors=
setlocal equalprg=
setlocal errorformat=
setlocal eventignorewin=
setlocal noexpandtab
if &filetype != 'help'
setlocal filetype=help
endif
setlocal fillchars=
setlocal findfunc=
setlocal fixendofline
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=jtcroql
setlocal formatprg=
setlocal grepformat=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=!-~,^*,^|,^\",192-255
setlocal keywordprg=:help
setlocal lhistory=10
setlocal nolinebreak
setlocal lisp
setlocal lispoptions=
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal nomodifiable
setlocal nrformats=bin,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=s:HelpComplete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal readonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=8
setlocal noshortname
setlocal showbreak=
setlocal sidescrolloff=-1
set signcolumn=yes
setlocal signcolumn=yes
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=%!airline#statusline(3)
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'help'
setlocal syntax=help
endif
setlocal tabstop=8
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal termwinkey=
setlocal termwinscroll=10000
setlocal termwinsize=
setlocal textwidth=78
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal wincolor=
setlocal nowinfixbuf
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal winhighlight=
set nowrap
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 2 - ((1 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 0
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 70 + 106) / 212)
exe 'vert 2resize ' . ((&columns * 70 + 106) / 212)
exe 'vert 3resize ' . ((&columns * 70 + 106) / 212)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
set shortmess=filnxtToOS
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
