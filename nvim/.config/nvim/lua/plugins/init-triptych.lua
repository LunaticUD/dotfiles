return {
	"simonmclean/triptych.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"nvim-tree/nvim-web-devicons", -- optional for icons
		"antosha417/nvim-lsp-file-operations", -- optional LSP integration
	},
	opts = {}, -- config options here
	keys = {
		{ "<leader>e", ":Triptych<CR>" },
	},
}
-- show_help = 'g?',
-- jump_to_cwd = '.',  -- Pressing again will toggle back
-- nav_left = 'h',
-- nav_right = { 'l', '<CR>' }, -- If target is a file, opens the file in-place
-- open_hsplit = { '-' },
-- open_vsplit = { '|' },
-- open_tab = { '<C-t>' },
-- cd = '<leader>cd',
-- delete = 'd',
-- add = 'a',
-- copy = 'c',
-- rename = 'r',
-- rename_from_scratch = 'R',
-- cut = 'x',
-- paste = 'p',
-- quit = 'q',
-- toggle_hidden = '<leader>.',
-- toggle_collapse_dirs = 'z',
