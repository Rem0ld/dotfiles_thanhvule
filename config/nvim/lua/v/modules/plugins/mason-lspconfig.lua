
return {
	"williamboman/mason-lspconfig.nvim",
    config = function ()
        require("mason-lspconfig").setup({
            ensure_installed = {"sumneko_lua", "rust_analyzer"}
        })
        -- code
    end
}
