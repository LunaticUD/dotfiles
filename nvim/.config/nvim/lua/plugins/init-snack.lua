return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		notifier = {
			enabled = true,
			style = "notification",
			max_notifications = 3,
			timeout = 2000,
			level = { min = vim.log.levels.WARN },

			filter = function(notification)
				-- 首先检查 notification 和 message 是否存在
				if not notification or not notification.message then
					return false -- 如果不存在，直接过滤掉
				end

				-- 确保 message 是字符串
				local msg = tostring(notification.message)

				-- 过滤热重载消息
				if string.find(msg, "Config Change Detected") then
					return false
				end

				-- 过滤其他不需要的消息
				local filtered_patterns = {
					"No information available",
					"already at",
					"E21:",
					"E32:",
					"written",
					"lines.*yanked",
					"more lines",
					"fewer lines",
					"^%s*$", -- 空消息
				}

				for _, pattern in ipairs(filtered_patterns) do
					if string.find(msg, pattern) then
						return false
					end
				end

				return true
			end,
		},
	},

	config = function(_, opts)
		require("snacks").setup(opts)
	end,
}
