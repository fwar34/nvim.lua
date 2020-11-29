-- https://github.com/glepnir/nvim/blob/master/lua/domain/global.lua

local global = {}
local home = os.getenv("HOME")
local path_sep = global.is_windows and '\\' or '/'

function global.dump(...)
	local objects = vim.tbl_map(vim.inspect, {...})
	print(unpack(objects))
end

-- https://blog.csdn.net/forestsenlin/article/details/50590577
-- string库的gsub函数，共三个参数：
-- 1. str是待分割的字符串
-- 2. '[^'..reps..']+'是正则表达式，查找非reps字符，并且多次匹配
-- 3. 每次分割完的字符串都能通过回调函数获取到，w参数就是分割后的一个子字符串，把它保存到一个table中
function global.split(str, reps)
	local resultStrList = {}
	string.gsub(str, '[^' .. reps .. ']+', function(w)
		table.insert(resultStrList, w)
	end)
	return resultStrList
end

local function read_total_memory()
	global.memory_enough = false
	if global.is_windows then
		global.memory_enough = true
	else
		local file, err = io.open("/proc/meminfo")
		if not err then
			local memory = global.split(file:read(), " ")
			-- print(vim.inspect(memory))
			-- global.dump(memory)
			global.memory_enough = tonumber(memory[2]) > 1000000
		end
	end
end

function global:load_variables()
	self.is_mac = jit.os == 'OSX'
	self.is_windows = jit.os == 'Windows'
	self.is_linux = jit.os == 'Linux'
	self.vim_path = home .. path_sep .. '.config' .. path_sep .. 'nvim'
	self.cache_dir = home .. path_sep .. '.cache' .. path_sep .. 'vim' .. path_sep
	self.path_sep = path_sep
	self.home = home
	self.memory_enough = read_total_memory()
end

global:load_variables()
return global
