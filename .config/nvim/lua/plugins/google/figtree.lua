-- https://g3doc.corp.google.com/experimental/users/jackcogdill/figtree/README.md?cl=head

return {
  url = 'sso://user/jackcogdill/nvim-figtree',
  keys = {
    {
      '<Leader>f',
      function()
        require('figtree').toggle()
      end,
    },
  },
	config = function()
		require('figtree').setup()
	end,
}
