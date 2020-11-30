local global = require('global')
-- local dein = {config_files = {}, repos = {}}
local dein = setmetatable({}, {__index = {config_files = {}, reps = {}}})

function dein:load()
end
