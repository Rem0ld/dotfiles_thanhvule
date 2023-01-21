return {
  "nvim-neo-tree/neo-tree.nvim",
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_diagnostics = false,
      source_selector = {
        winbar = true,
        content_layout = "center",
        tab_labels = {
          filesystem = global.get_icon "FolderClosed" .. " File",
          buffers = global.get_icon "DefaultFile" .. " Bufs",
          git_status = global.get_icon "Git" .. " Git",
          diagnostics = global.get_icon "Diagnostic" .. " Diagnostic",
        }
      },
      default_component_configs = {
        indent = { padding = 0 },
        icon = {
          folder_closed = global.get_icon "FolderClosed",
          folder_open = global.get_icon "FolderOpen",
          folder_empty = global.get_icon "FolderEmpty",
          default = global.get_icon "DefaultFile",
        },
        git_status = {
          symbols = {
            added = global.get_icon "GitAdd",
            deleted = global.get_icon "GitDelete",
            modified = global.get_icon "GitChange",
            renamed = global.get_icon "GitRenamed",
            untracked = global.get_icon "GitUntracked",
            ignored = global.get_icon "GitIgnored",
            unstaged = global.get_icon "GitUnstaged",
            staged = global.get_icon "GitStaged",
            conflict = global.get_icon "GitConflict",
          },
        },
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          o = "open",
          H = "prev_source",
          L = "next_source",
        },
      },

      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
        },
      },
    })
  end,

}
