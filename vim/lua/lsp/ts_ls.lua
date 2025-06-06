 return {
	 root_dir = lspconfig.util.root_pattern('tsconfig.json', 'package.json'),
	 single_file_support = true,
	 root_markers = {'package.json'}:help lspconfig-all,
 }
