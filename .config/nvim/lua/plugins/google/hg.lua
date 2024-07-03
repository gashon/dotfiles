return {
	{'nvim-lua/plenary.nvim'},
	{
	    "ipod825/libp.nvim",
	    config = function()
		require("libp").setup()
	    end,
	},
	{
	    url = "sso://user/smwang/hg.nvim",
	    config = function()
		require("hg").setup()
	    end,
	}
}
