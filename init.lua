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
  spec = {
    {
      "jose-elias-alvarez/null-ls.nvim",
      ft = "lua",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.stylua,
          },
          on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr })
                end,
              })
            end
          end,
        })
      end,
    },
    {
      "cocopon/iceberg.vim",
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
      config = function()
        require("lualine").setup({
          options = {
            icons_enabled = false,
            theme = "iceberg_dark",
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = {
              {
                function()
                  if vim.opt.paste:get() then
                    return "PASTE"
                  else
                    return ""
                  end
                end,
                color = { fg = "#ff00ff", gui = "bold" },
              },
              "branch",
              "diff",
              "diagnostics",
            },
            lualine_c = { "filename" },
            lualine_x = { "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
        })
      end,
    },
    {
      "kyazdani42/nvim-tree.lua",
      dependencies = "kyazdani42/nvim-web-devicons",
      config = function()
        vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "gj", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        require("nvim-tree").setup()
      end,
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local caps = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig").rust_analyzer.setup({ capabilities = caps })
        require("lspconfig").pyright.setup({ capabilities = caps })
        require("lspconfig").lua_ls.setup({ capabilities = caps })
      end,
    },
    {
      "williamboman/mason.nvim",
      dependencies = { "williamboman/mason-lspconfig.nvim" },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "rust_analyzer", "pyright", "lua_ls" },
        })
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }),
        })
        require("lspconfig").lua_ls.setup({
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(".git", ".luarc.json")(fname) or util.path.dirname(fname)
          end,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        })
        require("lspconfig").bashls.setup({
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          filetypes = { "sh", "bash" },
          cmd = { "bash-language-server", "start" },
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local t = require("telescope.builtin")
        local actions = require("telescope.actions")
        vim.keymap.set("n", "<leader>k", t.live_grep)
        vim.keymap.set("n", "gk", t.live_grep)
        vim.keymap.set("n", "<leader>f", function()
          t.find_files({ hidden = true })
        end)
        vim.keymap.set("n", "<leader>o", t.oldfiles)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "TelescopePrompt",
          callback = function()
            vim.keymap.set("n", "q", function()
              local prompt_bufnr = vim.api.nvim_get_current_buf()
              actions.close(prompt_bufnr)
            end, { buffer = true })
          end,
        })
      end,
    },
    {
      "is0n/jaq-nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("jaq-nvim").setup({
          cmds = {
            internal = {
              lua = "luafile %",
              vim = "source %",
            },
            external = {
              python = "python3 %",
              go = "go run %",
              sh = "sh %",
              ruby = "ruby %",
              javascript = "node %",
              rust = "cargo run --quiet %",
            },
          },
          behavior = {
            default = "float",
            startinsert = true,
            wincmd = false,
            autosave = false,
          },
          ui = {
            float = {
              border = "none",
              winhl = "Normal",
              borderhl = "FloatBorder",
              winblend = 0,
              height = 0.8,
              width = 0.8,
              x = 0.5,
              y = 0.5,
            },
            terminal = {
              position = "bot",
              size = 10,
              line_no = false,
            },
            quickfix = {
              position = "bot",
              size = 10,
            },
          },
        })
        vim.keymap.set("n", "g<space>", ":<C-u>Jaq<CR>", { silent = true })
      end,
    },
    "thinca/vim-visualstar",
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    },
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },
    {
      "kylechui/nvim-surround",
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({})
      end,
    },
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "vim-scripts/vcscommand.vim",
    {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
            auto_trigger = true,
            keymap = {
              accept = "<C-l>",
            },
          },
          filetypes = {
            ["*"] = true,
          },
        })
      end,
    },

    {
      "cespare/vim-toml",
      ft = "toml",
    },

    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      build = "cd app && yarn install",
      config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_refresh_slow = 0
        vim.g.mkdp_command_for_global = 0
        vim.g.mkdp_open_to_the_world = 0
        vim.g.mkdp_open_ip = ""
        vim.g.mkdp_browser = ""
        vim.g.mkdp_echo_preview_url = 0
        vim.g.mkdp_browserfunc = ""
        vim.g.mkdp_preview_options = {
          mkit = {},
          katex = {},
          uml = {},
          maid = {},
          disable_sync_scroll = 0,
          sync_scroll_type = "middle",
          hide_yaml_meta = 1,
          sequence_diagrams = {},
        }
        vim.g.mkdp_markdown_css = ""
        vim.g.mkdp_highlight_css = ""
        vim.g.mkdp_port = ""
        vim.g.mkdp_page_title = "「${name}」"
      end,
    },
    {
      "chentoast/marks.nvim",
      event = "VeryLazy",
      opts = {},
    },
  },
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
  "wrapscan",
  "ignorecase",
}) do
  vim.opt[opt] = false
end

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

-- Move by display lines
for _, mode in ipairs({ "n", "o", "x" }) do
  vim.keymap.set(mode, "j", "gj", { silent = true })
  vim.keymap.set(mode, "k", "gk", { silent = true })
end

vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "Q", ":set paste!<CR>", { silent = true })
vim.keymap.set("n", "W", ":set wrap!<CR>", { silent = true })
vim.keymap.set("n", "S", ":set number!<CR>", { silent = true })
vim.keymap.set("n", "z", ":set filetype=")

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

-- Jump to previous/next location
vim.keymap.set("n", "<leader>h", "<C-o>", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-i>", { silent = true })

-- Load matchit
vim.cmd("runtime macros/matchit.vim")
vim.keymap.set("n", "<space>", "%", { silent = true })
vim.keymap.set("v", "<space>", "%", { silent = true })
vim.keymap.set("v", "m", "%", { silent = true })

-- Edit configuration files
vim.keymap.set("n", "g,", ":<C-u>edit $HOME/.config/nvim/init.lua<CR>", { silent = true })

-- Move to the beginning/end of the line
vim.keymap.set("n", "gh", "^", { silent = true })
vim.keymap.set("v", "gh", "^", { silent = true })
vim.keymap.set("n", "gl", "$", { silent = true })
vim.keymap.set("v", "gl", "$<Left>", { silent = true })

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
  pattern = "qf",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-w><CR><C-w>T", { noremap = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "rust", "python" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})
