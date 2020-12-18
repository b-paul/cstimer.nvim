" cstimer vim plugin

if !exists(":Cstimer")
    command -nargs=0 Cstimer :lua require("cstimer").init()
endif
