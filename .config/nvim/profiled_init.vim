lua p = require("jit.p")
lua p.start("10,p,l,v,r,m0,i1", "/tmp/lua-profiling.log")
profile start /tmp/vim-profiling.log
profile func *
profile file *

" Your ordinary init.lua runs here
source ~/.config/nvim/init.lua

profile stop
silent! profile dump
lua p.stop()

tabnew "tabnew"
edit   /tmp/lua-profiling.log
vsplit /tmp/vim-profiling.log
