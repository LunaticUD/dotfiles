return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		-- 【核心功能 1：类似 VS Code Ctrl+D -> 改为 Alt+n】
		-- 选中光标下的单词，每按一次，选中下一个相同的单词
		-- <C-n> 改为 <A-n>
		set({ "n", "v" }, "<A-n>", function()
			mc.matchAddCursor(1)
		end, { desc = "Select Next Word" })

		-- 跳过当前选中的这个，去找下一个
		-- <C-x> 改为 <A-x>
		set({ "n", "v" }, "<A-x>", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip Match" })

		-- 向上查找选中 (反向)
		-- <C-p> 改为 <A-p>
		set({ "n", "v" }, "<A-p>", function()
			mc.matchAddCursor(-1)
		end, { desc = "Select Prev Word" })

		-- 【核心功能 2：垂直添加光标】
		-- 使用 Alt + 上/下 来垂直添加光标
		-- <C-Up> 改为 <A-Up>
		set({ "n", "v" }, "<A-Up>", function()
			mc.lineAddCursor(-1)
		end, { desc = "Add Cursor Above" })
		set({ "n", "v" }, "<A-Down>", function()
			mc.lineAddCursor(1)
		end, { desc = "Add Cursor Below" })

		-- 【鼠标支持】
		-- Alt + 左键点击添加光标
		set("n", "<A-LeftMouse>", mc.handleMouse)

		-- 【特殊模式按键】
		mc.addKeymapLayer(function(layerSet)
			-- 按 Esc 退出多光标模式 (保持不变，最稳妥)
			layerSet("n", "<Esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)

			-- 删除当前那个光标
			layerSet("n", "<leader>x", mc.deleteCursor)
		end)

		-- 【外观美化】(保持不变)
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { link = "Cursor" })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
