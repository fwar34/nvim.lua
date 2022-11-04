local api = vim.api
local buf, win

local function open_window()
    buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    local width = api.nvim_get_option('columns')
    local height = api.nvim_get_option('lines')

    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)

    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    local opts = {
        style = 'minimal',
        relative = 'editor',
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }

    -------------------------------
    win = api.nvim_open_win(buf, true, opts)

    local border_buf = api.nvim_create_buf(false, true)
    local border_opts = {
        style = 'minimal',
        relative = 'editor',
        width = win_width + 2,
        height = win_height + 2,
        row = row - 1,
        col = col - 1
    }

    local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
end
