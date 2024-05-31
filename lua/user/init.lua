local M = {
	lsp = {},
}

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
M.borderstyle = {
	border = M.border,
	winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
}

M.icons = {
	kind = {
		Array = "",
		Boolean = "",
		Class = "",
		Color = "",
		Constant = "",
		Constructor = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "󰉋",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		-- Module = " ",
		Module = "",
		Namespace = "",
		Null = "󰟢",
		Number = "",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
		Supermaven = "",
		Table = "",
		Schema = "",
	},
	diagnostic = {
		BoldError = "",
		Error = "",
		BoldWarning = "",
		Warning = "",
		BoldInformation = "",
		Information = "",
		BoldQuestion = "",
		Question = "",
		BoldHint = "",
		Hint = "󰌶",
		Debug = "",
		Trace = "✎",
	},
	git = {
		LineAdded = " ",
		LineModified = " ",
		LineRemoved = " ",
		FileDeleted = " ",
		FileIgnored = "◌",
		FileRenamed = " ",
		FileStaged = "S",
		FileUnmerged = "",
		FileUnstaged = "",
		FileUntracked = "U",
		Diff = " ",
		Repo = "",
		Octoface = " ",
		Copilot = " ",
		Branch = "",
	},
	ui = {
		ArrowCircleDown = "",
		ArrowCircleLeft = "",
		ArrowCircleRight = "",
		ArrowCircleUp = "",
		BoldArrowDown = "",
		BoldArrowLeft = "",
		BoldArrowRight = "",
		BoldArrowUp = "",
		BoldClose = "",
		BoldDividerLeft = "",
		BoldDividerRight = "",
		BoldLineLeft = "▎",
		BoldLineMiddle = "┃",
		BoldLineDashedMiddle = "┋",
		BookMark = "",
		BoxChecked = "",
		Bug = "",
		Stacks = "",
		Scopes = "",
		Watches = "󰂥",
		DebugConsole = "",
		Calendar = "",
		Check = "",
		ChevronRight = "",
		ChevronShortDown = "",
		ChevronShortLeft = "",
		ChevronShortRight = "",
		ChevronShortUp = "",
		Circle = "",
		Close = "󰅖",
		CloudDownload = "",
		Code = "",
		Comment = "",
		Dashboard = "",
		DividerLeft = "",
		DividerRight = "",
		DoubleChevronRight = "»",
		Ellipsis = "",
		EmptyFolder = "",
		EmptyFolderOpen = "",
		File = "",
		FileSymlink = "",
		Files = "",
		FindFile = "󰈞",
		FindText = "󰊄",
		Fire = "",
		Folder = "󰉋",
		FolderOpen = "",
		FolderSymlink = "",
		Forward = "",
		Gear = "",
		History = "",
		Lightbulb = "",
		LineLeft = "▏",
		LineMiddle = "│",
		List = "",
		Lock = "",
		NewFile = "",
		Note = "",
		Package = "",
		Pencil = "󰏫",
		Plus = "",
		Project = "",
		Search = "",
		SignIn = "",
		SignOut = "",
		Tab = "󰌒",
		Table = "",
		Target = "󰀘",
		Telescope = "",
		Text = "",
		Tree = "",
		Triangle = "󰐊",
		TriangleShortArrowDown = "",
		TriangleShortArrowLeft = "",
		TriangleShortArrowRight = "",
		TriangleShortArrowUp = "",
	},
	diagnostics = {
		BoldError = "",
		Error = "",
		BoldWarning = "",
		Warning = "",
		BoldInformation = "",
		Information = "",
		BoldQuestion = "",
		Question = "",
		BoldHint = "",
		Hint = "󰌶",
		Debug = "",
		Trace = "✎",
	},
	misc = {
		Robot = "󰚩",
		Squirrel = "",
		Tag = "",
		Watch = "",
		Smiley = "",
		Package = "",
		CircuitBoard = "",
	},
}

--- Parse the filename from path string
---
--- @param path string path to file
--- @return string filename without extension
M.get_filename = function(path)
	local start, _ = path:find("[^/\\]+.lua$")
	return path:sub(start, #path - 4)
end

--- Merge lists together into a new single list
---
--- @param ... table<integer, any>
--- @return table<integer, any>
M.merge_lists = function(...)
	local result = {}
	for _, list in ipairs({ ... }) do
		for _, item in ipairs(list) do
			if not vim.tbl_contains(result, function(v)
				return vim.deep_equal(v, item)
			end) then
				table.insert(result, item)
			end
		end
	end

	return result
end

return M
