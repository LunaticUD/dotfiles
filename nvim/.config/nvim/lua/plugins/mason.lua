return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "pyright", "stylua", "r-languageserver", "prettier" },
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}
