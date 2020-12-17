local fennel = require("fennel")
table.insert(package.loaders or package.searchers, fennel.searcher)
-- 这种方式嵌入fennel，启动nvim的时候必须在~/.config/nvim/lua目录，否则找不到mylib.fnl
local mylib = require("mylib") -- will compile and load code in mylib.fnl
local utils = require("utils")
