-- reference from https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__internal.lua
local api = vim.api
local pickers = require('telescope.pickers')
local make_entry = require "telescope.make_entry"
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local manager = require('group.manager')

local buffers = function(opts)
    opts = opts or {}
    local bufnrs = vim.tbl_filter(function(b)
        if 1 ~= vim.fn.buflisted(b) then
            return false
        end
        -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
        if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
            return false
        end
        if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
            return false
        end
        if opts.cwd_only and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true) then
            return false
        end
        if not opts.cwd_only and opts.cwd and not string.find(vim.api.nvim_buf_get_name(b), opts.cwd, 1, true) then
            return false
        end

        if manager.is_buf_exclude(b) then
            return false
        end

        local buffer_groups = api.nvim_buf_get_var(b, 'buffer_group')
        if buffer_groups and not vim.tbl_contains(buffer_groups, manager.current_group()) then
            return false
        end

        return true
    end, vim.api.nvim_list_bufs())
    if not next(bufnrs) then
        return
    end
    if opts.sort_mru then
        table.sort(bufnrs, function(a, b)
            return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
        end)
    end

    local buffers = {}
    local default_selection_idx = 1
    for _, bufnr in ipairs(bufnrs) do
        local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

        if opts.sort_lastused and not opts.ignore_current_buffer and flag == "#" then
            default_selection_idx = 2
        end

        local element = {
            bufnr = bufnr,
            flag = flag,
            info = vim.fn.getbufinfo(bufnr)[1],
        }

        if opts.sort_lastused and (flag == "#" or flag == "%") then
            local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
            table.insert(buffers, idx, element)
        else
            table.insert(buffers, element)
        end
    end

    if not opts.bufnr_width then
        local max_bufnr = math.max(unpack(bufnrs))
        opts.bufnr_width = #tostring(max_bufnr)
    end

    pickers
    .new(opts, {
        prompt_title = "Buffers",
        finder = finders.new_table {
            results = buffers,
            entry_maker = opts.entry_maker or make_entry.gen_from_buffer(opts),
        },
        previewer = conf.grep_previewer(opts),
        sorter = conf.generic_sorter(opts),
        default_selection_index = default_selection_idx,
    })
    :find()
end

buffers()
