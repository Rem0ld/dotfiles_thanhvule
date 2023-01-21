-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>/", ":nohlsearch<CR>", { silent = true })
map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { silent = true })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { silent = true })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { silent = true })
map("n", "<leader>j", ":m .+1<cr>==", { silent = true })
map("n", "<leader>k", ":m .-2<cr>==", { silent = true })
map("n", "<leader>vm", ":vsp ~/.config/nvim/lua/user/init.lua<cr>", { silent = true })
map("n", "<leader>sv", ":source ~/.config/nvim/lua/user/init.lua<cr>", { silent = true })
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })
map("n", "[q", ":cp<cr><cr>", { silent = true })
map("n", "]q", ":cn<cr><cr>", { silent = true })
map("n", "<leader>d", '"_d', { silent = true })
map("i", "kj", "<esc>", { silent = true })
map("i", "jj", "<esc>", { silent = true })
map("i", "kk", "<esc>", { silent = true })
map("i", "kj", "<esc>", { silent = true })
map("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
