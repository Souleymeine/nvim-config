require("jdtls").start_or_attach({
	cmd = {
		'java', -- or '/path/to/java21_or_newer/bin/java'
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1G',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar',
		'/usr/libexec/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar',
		-- NOTE : the user should own thid directory, not root, because it attempts to write logs there
		'-configuration', '/usr/share/jdtls/config_linux',
		-- See `data directory configuration` section in the README
		'-data', os.getenv('HOME') .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fs.root(0, {'gradlew', '.git', 'mvnw'}) or "./jdtls_cache", ":p:h:t")
	},
})
