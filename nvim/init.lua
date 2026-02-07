vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
-- Hide cmd line when not in use
vim.opt.cmdheight = 0

-- Case insensitive search if only lowercase. Case sensitive otherwise
vim.opt.ignorecase = true
vim.opt.smartcase = true

local function undo_settings()
	local undo_dir = vim.fn.stdpath('cache') .. '/undo/'
	vim.fn.mkdir(undo_dir, 'p')
	vim.opt.undodir = undo_dir
	vim.opt.undofile = true
	vim.opt.undolevels = 1000
end

local function set_colors()
	-- Enable 24 bit colors
	vim.opt.termguicolors = true
end

undo_settings()
set_colors()
