return {
	{
		{ "nvim-lua/plenary.nvim", priority = 1000 },
		{ "kyazdani42/nvim-web-devicons" },
		-- ui
		{
			"olivercederborg/poimandres.nvim",
			config = function()
				vim.cmd([[colorscheme poimandres]])
			end,
		},
		{
			"stevearc/oil.nvim",
			config = function()
				require("oil").setup({
					keymaps = {
						["g?"] = "actions.show_help",
						["<S-l>"] = "actions.select",
						["<S-k>"] = "actions.select_vsplit",
						["<S-j>"] = "actions.select_split",
						["<S-o>"] = "actions.select_tab",
						["<S-p>"] = "actions.preview",
						["<esc>"] = "actions.close",
						["<S->>"] = "actions.refresh",
						["-"] = "actions.parent",
						["_"] = "actions.open_cwd",
						["`"] = "actions.cd",
						["~"] = "actions.tcd",
						["<S-h>"] = "actions.toggle_hidden",
					},
				})
			end,
		},
		{
			"krapjost/neodev.nvim",
			config = function()
				require("neodev").setup()
			end,
		},
		{
			"krapjost/term.nvim",
			config = function()
				require("neo-term").setup({})
			end,
		},
		-- {
		-- 	"AckslD/messages.nvim",
		-- 	config = function()
		-- 		require("messages").setup()
		-- 	end,
		-- },
		{
			"j-hui/fidget.nvim",
			config = require("plugins.config.fidget"),
		},
		-- {
		-- 	"norcalli/nvim-colorizer.lua",
		-- 	config = function()
		-- 		require("colorizer").setup()
		-- 	end,
		-- },
		{ "windwp/nvim-spectre" },
		{
			"ThePrimeagen/harpoon",
			dependencies = "nvim-lua/plenary.nvim",
			config = require("plugins.config.harpoon"),
		},
		{
			"folke/which-key.nvim",
			config = require("plugins.config.whichkey"),
			lazy = true,
		},
		{ "folke/trouble.nvim" },
		{
			"folke/todo-comments.nvim",
			config = function()
				require("todo-comments").setup()
			end,
		},
		{ "tpope/vim-repeat" },
		{ "tpope/vim-surround" },
		{
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		},
		{ "ggandor/leap.nvim", config = require("plugins.config.leap") },
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup()
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			config = require("plugins.config.treesitter"),
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			dependencies = "nvim-treesitter/nvim-treesitter",
		},
		{ "p00f/nvim-ts-rainbow" },
		{
			"lewis6991/gitsigns.nvim",
			config = require("plugins.config.gitsigns"),
		},
		{
			"sindrets/diffview.nvim",
		},
		{
			"timuntersberger/neogit",
			config = require("plugins.config.neogit"),
			dependencies = {
				"nvim-lua/plenary.nvim",
				"sindrets/diffview.nvim",
			},
		},

		-- lsp --
		{
			"neovim/nvim-lspconfig",
		},
		{
			"SmiteshP/nvim-navic",
			dependencies = "neovim/nvim-lspconfig",
			config = require("plugins.config.navic"),
		},
		{
			"williamboman/mason.nvim",
			config = require("plugins.config.mason"),
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = require("plugins.config.mason-lspconfig"),
			dependencies = { "neovim/nvim-lspconfig" },
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			config = require("plugins.config.null-ls"),
		},
		{
			"nvim-telescope/telescope.nvim",
			config = require("plugins.config.telescope"),
		},
		{
			"nvim-telescope/telescope-symbols.nvim",
			dependencies = {
				"nvim-telescope/telescope.nvim",
			},
		},
		{ "kkharji/sqlite.lua" },
		{
			"nvim-telescope/telescope-frecency.nvim",
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"kkharji/sqlite.lua",
			},
		},
		{
			"cljoly/telescope-repo.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
			},
		},
		{
			"L3MON4D3/LuaSnip",
			version = "1.2.1",
			build = "make install_jsregexp",
			config = require("plugins.config.luasnip"),
		},
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{
			"hrsh7th/nvim-cmp",
			config = require("plugins.config.cmp"),
		},
		-- AI
		{
			"zbirenbaum/copilot.lua",
			config = require("plugins.config.copilot"),
		},
		{
			"zbirenbaum/copilot-cmp",
			dependencies = { "copilot.lua" },
			config = function()
				require("copilot_cmp").setup()
			end,
		},
		{
			"jbyuki/instant.nvim",
		},
		{
			"gleam-lang/gleam.vim",
		},
	},
}
