vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = true

-- someday I will create my own color scheme, as Nord overuses some colors with red components,
-- but for now 'Nord' is the closest to what I am looking for
-- however, I prefer contrasty window with black backgroune and use Nord's background
-- only for inactive ones

require('nord').set()

--16 colors Nord color table as a reference:
--nord0_gui = "#2E3440", -- nord0 in palette
--nord1_gui = "#3B4252", -- nord1 in palette
--nord2_gui = "#434C5E", -- nord2 in palette
--nord3_gui = "#4C566A", -- nord3 in palette
--nord3_gui_bright = "#616E88", -- out of palette
--nord4_gui = "#D8DEE9", -- nord4 in palette
--nord5_gui = "#E5E9F0", -- nord5 in palette
--nord6_gui = "#ECEFF4", -- nord6 in palette
--nord7_gui = "#8FBCBB", -- nord7 in palette
--nord8_gui = "#88C0D0", -- nord8 in palette
--nord9_gui = "#81A1C1", -- nord9 in palette
--nord10_gui = "#5E81AC", -- nord10 in palette
--nord11_gui = "#BF616A", -- nord11 in palette
--nord12_gui = "#D08770", -- nord12 in palette
--nord13_gui = "#EBCB8B", -- nord13 in palette
--nord14_gui = "#A3BE8C", -- nord14 in palette
--nord15_gui = "#B48EAD", -- nord15 in palette
--none = "NONE",
-- replace active background and update non-active to standare Nord background color
vim.api.nvim_command("highlight NormalNC guibg=#2E3440")
vim.api.nvim_command("highlight Normal guibg=black")

-- override the background for termanal/packer/etc
vim.cmd([[augroup nord]])
vim.cmd([[  autocmd!]])
vim.cmd([[  autocmd ColorScheme * lua require("nord.util").onColorScheme()]])
vim.cmd([[  autocmd TermOpen * setlocal winhighlight=Normal:black,NormalNC:NormalNC,SignColumn:NormalFloat]])
vim.cmd([[  autocmd FileType packer setlocal winhighlight=Normal:black,NormalNC:NormalNC,SignColumn:NormalFloat]])
vim.cmd([[  autocmd FileType qf setlocal winhighlight=Normal:black,NormalNC:NormalNC,SignColumn:NormalFloat]])
vim.cmd([[augroup end]])

