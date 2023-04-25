local dap = require('dap')

local function dap_python_command()
  if 'Linux' == vim.loop.os_uname().sysname then
    return 'python3'
  else
    return 'python.exe'
    -- return 'C:/tools/Anaconda3/python.exe'
  end
end

dap.adapters.python = {
    type = 'executable';
    command = dap_python_command();
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = 'Launch file';
        program = '${file}';
        console = 'integratedTerminal';
    },
}

