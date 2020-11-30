local options = require('options')
local plugins = require('plugins')

local core = {}

function core.init()
        options:load_options()
end

return core
