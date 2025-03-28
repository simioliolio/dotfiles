return {
	"mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
	config = function()
    require("dap-python").setup("uv")
    require("dapui").setup()
		local dap = require("dap")
--    dap.adapters.python = {
--      type = "executable",
--      command = "python3",
--      args = { "-m", "debugpy.adapter" },
--    }
		dap.configurations.python = {
			{
				type = "python",
				request = "attach",
				name = "Attach to remote",
				connect = {
					host = "0.0.0.0",
					port = 5789,
				},
				justMyCode = false, -- Don't step into std lib
				pythonPath = function()
					local project_root = vim.fn.getcwd()
					local venv_py_bin = project_root .. "/.venv/bin/python"
					if vim.fn.filereadable(venv_py_bin) == 0 then
						error("no python bin found at " .. venv_py_bin .. ". Activate a venv in the project!")
					else
						return venv_py_bin
					end
				end,
			},
		}
	end,
}
