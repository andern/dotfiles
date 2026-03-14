local harpoon = require("harpoon")
local telescope = require("telescope.builtin")

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
-- Hide cmd line when not in use
vim.opt.cmdheight = 0

-- Case insensitive search if only lowercase. Case sensitive otherwise
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable some providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

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
	vim.cmd.colorscheme "tokyonight-night"
end

local function harpoon_setup()
	harpoon:setup();
	vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
	vim.keymap.set("n", "<M-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

	vim.keymap.set("n", "<M-æ>", function() harpoon:list():select(1) end)
	vim.keymap.set("n", "<M-.>", function() harpoon:list():select(2) end)
	vim.keymap.set("n", "<M-y>", function() harpoon:list():select(3) end)
	vim.keymap.set("n", "<M-å>", function() harpoon:list():select(4) end)

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<M-p>", function() harpoon:list():prev() end)
	vim.keymap.set("n", "<M-n>", function() harpoon:list():next() end)
end

local function telescope_setup()
	vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
	vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })
end

undo_settings()
set_colors()
harpoon_setup()
telescope_setup()
