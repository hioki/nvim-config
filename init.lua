local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = { lazy = true },
  spec = {
    {
      "cocopon/iceberg.vim",
      lazy = false,
      config = function()
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            vim.cmd("colorscheme iceberg")
            vim.api.nvim_set_hl(0, "Visual", { bg = "#3a4b5c", reverse = true })
          end,
        })
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      lazy = false
    },
    {
      "Shougo/vimfiler.vim",
      cmd = "VimFilerBufferDir",
      lazy = false,
      dependencies = "Shougo/unite.vim",
      config = function()
        vim.fn['vimfiler#custom#profile']("default", "context", { safe = 0, auto_expand = 1, parent = 0 })
        vim.g.vimfiler_as_default_explorer = true
        vim.g.vimfiler_tree_leaf_icon      = " "
        vim.g.vimfiler_tree_opened_icon    = "▾"
        vim.g.vimfiler_tree_closed_icon    = "▸"
        vim.g.vimfiler_file_icon           = "-"
        vim.g.vimfiler_marked_file_icon    = "*"
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "vimfiler",
          callback = function()
            local opts = { noremap = true, silent = true, buffer = true }
            vim.keymap.set("n", "s", "<Cmd>lua vimfiler#do_switch_action('vsplit')<CR>", opts)
            vim.keymap.set("n", "v", "<Cmd>lua vimfiler#do_switch_action('split')<CR>", opts)
            vim.keymap.set("n", "t", "<Cmd>lua vimfiler#do_action('tabopen')<CR>", opts)
            vim.keymap.del("n", "<C-l>", { buffer = true })
          end,
        })
        vim.keymap.set("n", "fe", ":VimFilerBufferDir -quit<CR>", { noremap = true, silent = true })
      end,
    },
    {
      "Shougo/vimproc.vim",
      event = { "BufReadPost", "BufNewFile" },
      build = "make -f make_mac.mak"
    },
    {
      "Shougo/deoplete.nvim",
      config = function()
        vim.g["deoplete#max_menu_width"] = 180
        vim.g.go_bin_path = os.getenv("HOME") .. "/go/bin"
      end,
    },
    {
      "Shougo/unite.vim",
      cmd = "Unite",
      config = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "unite",
          callback = function()
            local opts = { noremap = true, silent = true, buffer = true }
            vim.keymap.set("n", "<ESC><ESC>", "<cmd>q<CR>", opts)
            vim.keymap.set("n", "<C-g>", "<cmd>q<CR>", opts)
            vim.keymap.set("i", "<ESC><ESC>", "<ESC>:q<CR>", opts)
            vim.keymap.set("i", "<C-g>", "<ESC>:q<CR>", opts)
          end,
        })
      end
    },
    {
      "thinca/vim-quickrun",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        vim.g.quickrun_config = {
          _ = { runner = "vimproc", ["runner/vimproc/updatetime"] = 60 },
          ruby = { command = "ruby", exec = { "%c %s" } },
          python = { command = "python3", exec = { "%c %s" } },
          typescript = { command = "ts-node", exec = { "%c %s" } },
          rust = { command = "cargo", exec = { "%c run --quiet %s" } },
        }
      end,
    },
    "thinca/vim-visualstar",
    "jiangmiao/auto-pairs",
    {
      "tomtom/tcomment_vim",
      config = function()
        vim.g.tcomment_opleader1 = "gc"
      end
    },

    "vim-scripts/camelcasemotion",
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "vim-scripts/vcscommand.vim",
    "tpope/vim-dispatch",
    "simeji/winresizer",
    "github/copilot.vim",

    {
      "cespare/vim-toml",
      ft = "toml"
    },

    {
      "powerman/vim-plugin-AnsiEsc",
      ft = "quickrun",
      dependencies = { "thinca/vim-quickrun" },
    },

    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      build = "cd app && yarn install",
      config = function()
        vim.g.mkdp_auto_start         = 0
        vim.g.mkdp_auto_close         = 0
        vim.g.mkdp_refresh_slow       = 0
        vim.g.mkdp_command_for_global = 0
        vim.g.mkdp_open_to_the_world  = 0
        vim.g.mkdp_open_ip            = ""
        vim.g.mkdp_browser            = ""
        vim.g.mkdp_echo_preview_url   = 0
        vim.g.mkdp_browserfunc        = ""
        vim.g.mkdp_preview_options    = {
          mkit                = {},
          katex               = {},
          uml                 = {},
          maid                = {},
          disable_sync_scroll = 0,
          sync_scroll_type    = "middle",
          hide_yaml_meta      = 1,
          sequence_diagrams   = {},
        }
        vim.g.mkdp_markdown_css       = ""
        vim.g.mkdp_highlight_css      = ""
        vim.g.mkdp_port               = ""
        vim.g.mkdp_page_title         = "「${name}」"
      end,
    },
  }
})

for _, opt in ipairs({
  "termguicolors",
  "number",
  "showmatch",
  "list",
  "autoread",
  "hidden",
  "lazyredraw",
  "autoindent",
  "smartindent",
  "smarttab",
  "incsearch",
  "hlsearch",
  "smartcase",
  "ttimeout",
}) do
  vim.opt[opt] = true
end

for _, opt in ipairs({
  "foldenable",
  "backup",
  "writebackup",
  "swapfile",
  "expandtab",
  "wrapscan",
  "ignorecase",
}) do
  vim.opt[opt] = false
end

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.laststatus = 2
vim.opt.textwidth = 0
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 50
vim.opt.mouse = "a"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.formatoptions = "lmoq"
vim.opt.visualbell = true
vim.cmd("set t_vb=")
vim.opt.wildmode = { "longest", "list" }
vim.opt.listchars = { tab = ">.", trail = "_", extends = ">", precedes = "<" }
vim.opt.display = "uhex"
vim.opt.directory:remove(".")
vim.opt.whichwrap:append("b,s,h,l,<,>,[,]")
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

-- Python provider
vim.g.python3_host_prog = os.getenv("HOME") .. "/.anyenv/envs/pyenv/shims/python3"

-- Move by display lines
for _, mode in ipairs({ "n", "o", "x" }) do
  vim.keymap.set(mode, "j", "gj", { silent = true })
  vim.keymap.set(mode, "k", "gk", { silent = true })
end

vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "Q", ":set paste!<CR>", { silent = true })
vim.keymap.set("n", "W", ":set wrap!<CR>", { silent = true })
vim.keymap.set("n", "S", ":set number!<CR>", { silent = true })
vim.keymap.set("n", "z", ":set filetype=", { silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })

-- Buffer navigation
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":bprevious<CR>", { silent = true })

-- Clipboard yank in visual
vim.keymap.set("v", "F", ":'<,'>w !pbcopy<CR><CR>", { silent = true })
vim.keymap.set("v", "v", "$h", { silent = true })

-- Insert mode cursor movement
vim.keymap.set("i", "<C-a>", "<Home>", { silent = true })
vim.keymap.set("i", "<C-e>", "<End>", { silent = true })
vim.keymap.set("i", "<C-b>", "<C-o>O", { silent = true })
vim.keymap.set("i", "<C-f>", "<C-o>o", { silent = true })
vim.keymap.set("i", "<C-d>", "<Del>", { silent = true })

-- Load matchit
vim.cmd("runtime macros/matchit.vim")
vim.keymap.set("n", "<Tab>", "%", { silent = true })
vim.keymap.set("v", "<Tab>", "%", { silent = true })
vim.keymap.set("v", "m", "%", { silent = true })

-- Edit configuration files
vim.keymap.set("n", "g,", ":<C-u>edit $HOME/.config/nvim/<CR>", { silent = true })

-- Move to the beginning/end of the line
vim.keymap.set("n", "gh", "^", { silent = true })
vim.keymap.set("v", "gh", "^", { silent = true })
vim.keymap.set("n", "gl", "$", { silent = true })
vim.keymap.set("v", "gl", "$<Left>", { silent = true })

-- QuickRun
vim.keymap.set("n", "g<Space>", ":<C-u>QuickRun<CR>", { silent = true })

-- Vimfiler
vim.keymap.set("n", "gj", ":<C-u>VimFilerBufferDir -quit<CR>", { silent = true })

-- Git commands
vim.keymap.set("n", "gd", ":<C-u>VCSDiff<CR>", { silent = true })
vim.keymap.set("n", "gD", ":<C-u>Gvdiff<CR>", { silent = true })
vim.keymap.set("n", "gb", ":<C-u>Git blame<CR>", { silent = true })

-- New buffer
vim.keymap.set("n", "<CR>n", ":new<CR>", { silent = true })
vim.keymap.set("n", "<CR>v", ":vnew<CR>", { silent = true })

-- Split buffer
vim.keymap.set("n", "<CR>N", ":split<CR>", { silent = true })
vim.keymap.set("n", "<CR>V", ":vsplit<CR>", { silent = true })

-- Close buffer
vim.keymap.set("n", "<CR>h", ":hide<CR>", { silent = true })
vim.keymap.set("n", "<CR>d", ":bd!<CR>", { silent = true })
vim.keymap.set("n", "<CR>q", ":q!<CR>", { silent = true })
vim.keymap.set("n", "<CR>Q", ":qall!<CR>", { silent = true })

-- Move between windows
vim.keymap.set("n", "sh", "<C-w>h", { silent = true })
vim.keymap.set("n", "sj", "<C-w>j", { silent = true })
vim.keymap.set("n", "sk", "<C-w>k", { silent = true })
vim.keymap.set("n", "sl", "<C-w>l", { silent = true })

-- Swap windows
vim.keymap.set("n", "srh", "<C-w>H", { silent = true })
vim.keymap.set("n", "srj", "<C-w>J", { silent = true })
vim.keymap.set("n", "srk", "<C-w>K", { silent = true })
vim.keymap.set("n", "srl", "<C-w>L", { silent = true })

-- Move between windows and close
vim.keymap.set("n", "sdh", "<C-w>h:bd!<CR>", { silent = true })
vim.keymap.set("n", "sdj", "<C-w>j:bd!<CR>", { silent = true })
vim.keymap.set("n", "sdk", "<C-w>k:bd!<CR>", { silent = true })
vim.keymap.set("n", "sdl", "<C-w>l:bd!<CR>", { silent = true })

-- FileType autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.foldenable = false
    vim.opt_local.tw = 0
    vim.opt_local.wrap = true
    vim.opt_local.formatoptions = ""
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "quickrun",
  command = "AnsiEsc",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-w><CR><C-w>T", { noremap = true, silent = true })
  end,
})

-- Lualine setup
require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "iceberg_dark",
  }
})
