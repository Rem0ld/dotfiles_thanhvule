local _ = {}

_.setup = function(on_attach)
	require("lspconfig").rust_analyzer.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return _
