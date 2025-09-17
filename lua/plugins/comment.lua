return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("Comment").setup({
      -- Custom commentstring for different filetypes
      pre_hook = function(ctx)
        -- For Python, always use line comments even in block mode
        if vim.bo.filetype == 'python' then
          -- Force line comments for Python in both line and block modes
          return require('Comment.ft').get('python', ctx.ctype == require('Comment.utils').ctype.linewise and 1 or 1)
        end
      end,
    })
  end,
}
