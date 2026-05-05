return {
    "j-morano/buffer_manager.nvim",
    config = function ()
        vim.keymap.set("n", "<leader>b", function()
            require("buffer_manager.ui").toggle_quick_menu()
        end, { silent = true })
    end
}
