local module_path = vim.fn.stdpath("data") .. '/Fload/'
if vim.fn.isdirectory(module_path) == 0 then
  vim.fn.mkdir(module_path, 'p')
end

function Fload(options)
  if not options or (options and type(options) ~= 'table') then
    vim.notify('module [%s] options is not table', vim.log.levels.ERROR, options[1])
    return
  end

  local modules = {}
  if type(options.dependencies) == 'string' then
    modules = { options[1], options.dependencies }
  elseif type(options.dependencies) == 'table' then
    modules = options.dependencies
    table.insert(modules, options[1])
  end

  for _, path in ipairs(modules) do
    module_path = module_path .. string.gsub(path, '%w+/(%w+)', '%1')
    if not vim.loop.fs_stat(module_path) then
      local cmd = "git clone https://github.com/" .. path .. ' ' .. module_path
      if os.execute(cmd) ~= 0 then
        return nil
      end
    end
    vim.opt.rtp:prepend(module_path)
  end

  if options.config then
    options.config()
  end
end
