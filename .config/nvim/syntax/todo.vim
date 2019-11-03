if exists("b:current_syntax")
    finish
endif

syntax match TODO "\<TODO\>"
syntax match STARTED "\<STARTED\>"
syntax match DONE "\<DONE\>"
syntax match CANCELED "\<CANCELED\>"

highlight TODO      ctermfg=red         term=bold
highlight STARTED   ctermfg=magenta     term=bold
highlight DONE      ctermfg=darkgreen
highlight CANCELED  ctermfg=blue

let b:current_syntax = "todo"
