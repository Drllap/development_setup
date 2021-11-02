local lspkind = require('lspkind')
lspkind.init()

local cmp = require('cmp')

cmp.setup {
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ["<C-q>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },

        ["<c-space>"] = cmp.mapping.complete(),
    },

    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path"     },
        { name = "buffer" , keyword_length = 5 },
    },

    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
            },
        },
    },
}
