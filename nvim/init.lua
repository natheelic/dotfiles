-- Ensure fzf is in PATH
local fzf_path = vim.fn.expand("~/.fzf/bin")
if vim.fn.isdirectory(fzf_path) == 1 and not vim.env.PATH:find(fzf_path, 1, true) then
  vim.env.PATH = fzf_path .. ":" .. vim.env.PATH
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- vim.g.codeium_platform_override = "mac-arm64"
