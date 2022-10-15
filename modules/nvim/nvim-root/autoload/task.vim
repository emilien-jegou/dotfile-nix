if exists("b:current_syntax")
  finish
endif

syntax keyword taskKeyword New new Working working Done done Todo TODO todo bug Bug

syntax match taskWorkingIcon "^\[-\].*" contained
syntax match taskWorkingIcon "^\s*\[-\].*" contained
syntax match taskDoneIcon "^\[x\]" contained
syntax match taskDoneIcon "^\s*\[x\]" contained

syntax match taskWorkingItem "^\[-\].*" contains=taskWorkingIcon,taskKeyword
syntax match taskWorkingItem "^\s*\[-\].*" contains=taskWorkingIcon,taskKeyword
syntax match taskDoneItem "^\[x\].*" contains=taskDoneIcon,taskKeyword
syntax match taskDoneItem "^\s*\[x\].*" contains=taskDoneIcon,taskKeyword

highlight taskKeyword guifg=#96CBFE guibg=NONE gui=NONE ctermfg=blue ctermbg=NONE cterm=NONE

highlight taskWorkingItem guifg=#f6f3e8 guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
highlight taskDoneItem guifg=#A8FF60 guibg=NONE gui=italic ctermfg=8 ctermbg=NONE cterm=NONE

highlight taskWorkingIcon guifg=#FF6C60 guibg=NONE gui=NONE ctermfg=green ctermbg=NONE cterm=NONE
highlight taskDoneIcon guifg=#A8FF60 guibg=NONE gui=italic ctermfg=8 ctermbg=NONE cterm=NONE

syntax match sectionTitleLine "^.*:\s*$" contains=sectionTitle
syntax match sectionTitle "\S.*:\s*$"
highlight sectionTitle guifg=#96CBFE guibg=NONE gui=bold,underline ctermfg=blue ctermbg=NONE cterm=bold,underline

syntax match taskPhase "^\s*-.*-\s*$" contains=taskDoneIcon,taskKeyword
highlight taskPhase guibg=NONE gui=bold ctermfg=5 ctermbg=NONE cterm=bold

syntax match taskIdea "^\s*->.*$" contains=taskDoneIcon,taskKeyword
highlight taskIdea guibg=NONE gui=bold ctermfg=3 ctermbg=NONE cterm=bold

syntax match taskIdea "^\s*->.*$" contains=taskDoneIcon,taskKeyword
highlight taskIdea guibg=NONE gui=bold ctermfg=4 ctermbg=NONE cterm=bold


let b:current_syntax = "task"

