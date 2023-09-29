local Terminal = require('toggleterm.terminal').Terminal
local buf_nr = 7

local nap = Terminal:new({
  cmd = "source scripts/nap-manager.sh",
  hidden = false,
  float_opts = {
    border = "double"
  },
  on_open = function(terminal)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(terminal.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  on_close = function(terminal)
    vim.cmd("startinsert!")
    -- vim.cmd('shell pbpaste')
  end,
  on_stdout = function(terminal, job, data, name)
    if data then
      print("Data")
      print(data)
      print(vim.inspect(data))
      vim.api.nvim_buf_set_lines(buf_nr, 0, -1, false, data)
    else
      print("No data")
    end
  end,
})

function Nap()
  nap:toggle()
end

