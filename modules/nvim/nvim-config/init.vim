let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

set runtimepath^=~/.nvim runtimepath+=~/.nvim/after

let &packpath = &runtimepath
source ~/.nvimrc

runtime! plugins/*.vim

let s:dein_dir = expand('~/.cache/nvim/packages/')
let s:dein_repo_dir = '~/.cache/nvim/packages/repos/github.com/shougo/dein.vim'

set runtimepath+=~/.cache/nvim/packages/repos/github.com/shougo/dein.vim

"Dein.vim come down from there if Github
if &runtimepath !~# '/dein.vim'
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml('~/.nvim/plugins/plugins.toml', {'lazy': 0})
  call dein#load_toml('~/.nvim/plugins/lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
