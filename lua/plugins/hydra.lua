local cmd = vim.cmd
return {
    {
        'anuvyklack/hydra.nvim',
        config = function()
            local Hydra = require('hydra')
            Hydra({
                name = 'Side scroll',
                mode = 'n',
                body = 'z',
                heads = {
                    { 'h', '5zh' },
                    { 'l', '5zl', { desc = '←/→' } },
                    { 'H', 'zH' },
                    { 'L', 'zL', { desc = 'half screen ←/→' } },
                }
            })

            local hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters  ^
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _q_ quit
  ^
  ^^^^                _<Esc>_
]]

            Hydra({
                name = 'Options',
                hint = hint,
                config = {
                    color = 'amaranth',
                    invoke_on_body = true,
                    hint = {
                        border = 'rounded',
                        position = 'bottom'
                    },
                },
                mode = { 'n', 'x' },
                body = '<leader>O',
                heads = {
                    { 'n', function()
                        if vim.o.number == true then
                            vim.o.number = false
                        else
                            vim.o.number = true
                        end
                    end, { desc = 'number' } },
                    { 'r', function()
                        if vim.o.relativenumber == true then
                            vim.o.relativenumber = false
                        else
                            vim.o.number = true
                            vim.o.relativenumber = true
                        end
                    end, { desc = 'relativenumber' } },
                    { 'v', function()
                        if vim.o.virtualedit == 'all' then
                            vim.o.virtualedit = 'block'
                        else
                            vim.o.virtualedit = 'all'
                        end
                    end, { desc = 'virtualedit' } },
                    { 'i', function()
                        if vim.o.list == true then
                            vim.o.list = false
                        else
                            vim.o.list = true
                        end
                    end, { desc = 'show invisible' } },
                    { 's', function()
                        if vim.o.spell == true then
                            vim.o.spell = false
                        else
                            vim.o.spell = true
                        end
                    end, { exit = true, desc = 'spell' } },
                    { 'w', function()
                        if vim.o.wrap ~= true then
                            vim.o.wrap = true
                            -- Dealing with word wrap:
                            -- If cursor is inside very long line in the file than wraps
                            -- around several rows on the screen, then 'j' key moves you to
                            -- the next line in the file, but not to the next row on the
                            -- screen under your previous position as in other editors. These
                            -- bindings fixes this.
                            vim.keymap.set('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end,
                                { expr = true, desc = 'k or gk' })
                            vim.keymap.set('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end,
                                { expr = true, desc = 'j or gj' })
                        else
                            vim.o.wrap = false
                            vim.keymap.del('n', 'k')
                            vim.keymap.del('n', 'j')
                        end
                    end, { desc = 'wrap' } },
                    { 'c', function()
                        if vim.o.cursorline == true then
                            vim.o.cursorline = false
                        else
                            vim.o.cursorline = true
                        end
                    end, { desc = 'cursor line' } },
                    { 'q', nil, { exit = true, desc = false  } },
                    { '<Esc>', nil, { exit = true } }
                }
            })

            local buffer_hydra = Hydra({
                name = 'Barbar',
                config = {
                    on_key = function()
                        -- Preserve animation
                        vim.wait(200, function() cmd 'redraw' end, 30, false)
                    end,
                },
                heads = {
                    { 'h', function() cmd('BufferLineCyclePrev') end, { on_key = false } },
                    { 'l', function() cmd('BufferLineCycleNext') end, { desc = 'choose', on_key = false } },

                    { 'H', function() cmd('BufferLineMovePrev') end },
                    { 'L', function() cmd('BufferLineMoveNext') end, { desc = 'move' } },

                    { 'p', function() cmd('BufferLineTogglePin') end, { desc = 'pin' } },
                    { '<C-p>', function() cmd('BufferLinePick') end, { desc = 'pick' } },

                    { 'c', function() cmd('BufferLinePickClose') end, { desc = 'pick close' } },

                    { 'od', function() cmd('BufferLineSortByDirectory') end, { desc = 'by directory' } },
                    { 'oe', function() cmd('BufferLineSortByExtension') end, { desc = 'by extension' } },
                    { 'q', nil, { exit = true, desc = false } },
                    { '<Esc>', nil, { exit = true, desc = 'quit' } }
                }
            })

            local function choose_buffer()
                if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
                    buffer_hydra:activate()
                end
            end

            vim.keymap.set('n', 'gb', choose_buffer, { desc = 'Barbar' })

            Hydra({
                name = 'vim-highlighter',
                config = {
                    color = 'amaranth',
                    invoke_on_body = true,
                    hint = {
                        border = 'rounded',
                        position = 'bottom'
                    },
                },
                mode = { 'n', 'x' },
                body = '<leader>so',
                heads = {
                    { 't', function() cmd('Hi+') end, { desc = 'HiSet' } },
                    { 'e', function() cmd('Hi-') end, { desc = 'HiErase' } },
                    { 'n', function() cmd('Hi>') end, { desc = 'Next' } },
                    { 'p', function() cmd('Hi<') end, { desc = 'Previous' } },
                    { ']', function() cmd('Hi}') end, { desc = 'Next' } },
                    { '[', function() cmd('Hi{') end, { desc = 'Previous' } },
                    { 's', function() cmd('Hi save') end, { desc = 'Save', exit = true } },
                    { 'l', function() cmd('Hi load') end, { desc = 'Load', exit = true } },
                    { 'c', function() cmd('Hi clear') end, { desc = 'Clear all', exit = true } },
                    { 'q', nil, { exit = true, desc = false } },
                    { '<Esc>', nil, { exit = true, desc = 'quit' } }
                }
            })
        end
    }
}
