-- =========================================================
-- Plugin: nvim-autopairs
-- Focus: Auto close quotes and brackets
-- =========================================================
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
            },
            disable_filetype = { "TelescopePrompt", "vim" },

            -- Works with the surround setting in /plugins/surround.lua (which uses normal mode)
            fast_wrap = {
                map = "<C-e>", -- Surround in insert mode
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%)%>%]%]%}%,]]=],
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        })

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if cmp_status_ok then
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}
