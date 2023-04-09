return function()
	local sidebar = require("sidebar-nvim")
	local harpoon = require("harpoon")

	local harpoon_marks = {
		title = "Harpoon Marks",
		icon = "",
		draw = function()
			local marks = harpoon.get_mark_config().marks
			local keymaps = { "H ", "T ", "N ", "S " }
			local lines = {}

			for idx = 1, #marks do
				if idx > 4 then
					table.insert(lines, "  " .. marks[idx].filename)
				else
					table.insert(lines, keymaps[idx] .. marks[idx].filename)
				end
			end

			return {
				lines = lines,
			}
		end,
	}

	local opts = {
		sections = { "todos", "files", harpoon_marks, "git" },
		files = {
			icon = "",
			show_hidden = true,
			ignored_paths = { "%.git$", "node_modules" },
		},
		hide_statusline = true,
		section_separator = { "" },
		section_title_separator = {},
		todos = { ignored_paths = { "snippets" } },
	}
	sidebar.setup(opts)
end
