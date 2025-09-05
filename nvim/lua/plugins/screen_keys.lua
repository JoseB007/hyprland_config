return {
  "NStefan002/screenkey.nvim",
  lazy = false,
  config = function()
    require("screenkey").setup({
      win_opts = {
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 1,
        relative = "editor",
        anchor = "SE",
        width = 50,
        height = 5,
        border = "rounded",
        title = "Screenkey",
        title_pos = "center",
        style = "minimal",
        focusable = false,
        noautocmd = true,
      },
    })
    -- Atajo para activar/desactivar
    vim.keymap.set("n", "<leader>sk", "<cmd>Screenkey toggle<cr>", { desc = "Toggle Screenkey" })
  end,
}
