return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
	  local config = require('nvim-treesitter.config')
	  config.setup({
		  auto_install = true, -- automatically install parsers for new langauages, that we don't nave parsers for
		  ensure_installed = { "lua", "javascript" },
		  highlight = { enabled = true },
		  indent = { enabled = true },
	  })
  end
}
