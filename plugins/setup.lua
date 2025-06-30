-- This script runs on startup to configure the plugin

-- Load the module we just created
local copy_buffers_module = require("copy-all-buffers")

-- Create the keymap that calls the function from our module
vim.keymap.set("n", "<leader>bc", copy_buffers_module.copy_all_to_clipboard, {
	noremap = true,
	silent = true,
	desc = "Copy All Buffers to Clipboard",
})
