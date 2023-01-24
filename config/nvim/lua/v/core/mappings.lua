-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- NORMAL
-- Standard
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader>/", ":nohlsearch<CR>", { silent = true })
map("n", "|", "<cmd>vsplit<cr>")
map("n", "\\", "<cmd>split<cr>")

-- TODO: add mappings
-- for lazy nvim
-- for buffers

-- Move lines
map("n", "<leader>j", ":m .+1<cr>==", { silent = true })
map("n", "<leader>k", ":m .-2<cr>==", { silent = true })

-- Buffers
map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { silent = true })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { silent = true })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { silent = true })

-- init.lua
map("n", "<leader>vm", ":vsp ~/.config/nvim/lua/user/init.lua<cr>", { silent = true })
map("n", "<leader>sv", ":source ~/.config/nvim/lua/user/init.lua<cr>", { silent = true })

-- Better vertical navigation
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })

-- Going through quicklist
map("n", "[q", ":cp<cr><cr>", { silent = true })
map("n", "]q", ":cn<cr><cr>", { silent = true })

-- Better delete ( remove from registers )
map("n", "<leader>d", '"_d', { silent = true })

-- Better escape
map("i", "kj", "<esc>", { silent = true })
map("i", "jj", "<esc>", { silent = true })
map("i", "kk", "<esc>", { silent = true })
map("i", "kj", "<esc>", { silent = true })

-- Telescope
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end)
map("n", "<leader>fF", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end)
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end)
map("n", "<leader>fm", function()
  require("telescope.builtin").marks()
end)
map("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end)
map("n", "<leader>fw", function()
  require("telescope.builtin").live_grep()
end)
map("n", "<leader>fW", function()
  require("telescope.builtin").live_grep({
    additional_args = function(args)
      return vim.list_extends(args, { "--hidden", "--no-ignore" })
    end,
  })
end)
map("n", "<leader>sb", function()
  require("telescope.builtin").git_branches()
end)
map("n", "<leader>sh", function()
  require("telescope.builtin").help_tags()
end)
map("n", "<leader>sm", function()
  require("telescope.builtin").man_pages()
end)
map("n", "<leader>sr", function()
  require("telescope.builtin").registers()
end)
map("n", "<leader>sk", function()
  require("telescope.builtin").keymaps()
end)
map("n", "<leader>sc", function()
  require("telescope.builtin").commands()
end)
map("n", "<leader>sn", function()
  require("telescope").extensions.notify.notify()
end)
map("n", "<leader>ls", function()
  local aerial_avail, _ = pcall(require, "aerial")
  if aerial_avail then
    require("telescope").extensions.aerial.aerial()
  else
    require("telescope.builtin").lsp_document_symbols()
  end
end)
map("n", "<leader>lD", function()
  require("telescope.builtin").diagnostics()
end)

-- Terminal
local ok, _ = pcall(require, "toggleterm.nvim")
if ok then
  local toggle_term_cmd = global.toggle_term_cmd
  if vim.fn.executable("gitui") == 1 then
    map("n", "<leader>gg", function()
      toggle_term_cmd("gitui")
    end)
  end
end

-- VISUAL
-- Move lines
map("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
