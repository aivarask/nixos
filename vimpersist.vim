let s:config = empty($XDG_CONFIG_HOME) ? expand("~/.config") : expand("$XDG_CONFIG_HOME")
let s:data   = empty($XDG_DATA_HOME)   ? expand("~/.local/share") : expand("$XDG_DATA_HOME")
let s:state  = empty($XDG_STATE_HOME)  ? expand("~/.local/state") : expand("$XDG_STATE_HOME")

if has('nvim') | let s:self='/nvim' | else | let s:self='/vim' | endif  

if isdirectory(s:config .. s:self) || 1
  func s:mkvimdir(dir)
    if !isdirectory(a:dir)
      call mkdir(a:dir, 'p', 0700)
    endif
    return a:dir
  endfunc

  " Use Data for packages, prevent duplicates
  if index(split(&packpath, ','), s:data .. s:self) == -1
	  exe $"set packpath^={s:data}{s:self}"
	  exe $"set packpath+={s:data}{s:self}/after"
  endif

  " These options are not set by default because they change the behavior of
  " where files are saved. Uncomment them if you want to fully move all
  " transient/persistent files to XDG directories.
  " Note: Undo/Views/Spell are placed in DATA_HOME as they are persistent,
  " while Swap/Backups use STATE_HOME as transient session state.

  " Persistent Data:
  let &undodir = s:mkvimdir(s:data .. s:self .. '/undo')
  set undofile
  let &viewdir = s:mkvimdir(s:data .. s:self .. '/view')
  let g:netrw_home = s:mkvimdir(s:data .. s:self)
  " call s:mkvimdir(s:data .. s:self .. '/spell')

  " Transient State:
  let &viminfofile = s:mkvimdir(s:state .. s:self) .. '/viminfo'
  let &directory = s:mkvimdir(s:state .. s:self .. '/swap')   .. '//'
  let &backupdir = s:mkvimdir(s:state .. s:self .. '/backup') .. '//'

  delfunction s:mkvimdir
endif

unlet s:config s:data s:state s:self

