return {
  'folke/todo-comments.nvim',
  opts={},
  keys = {
    { '<leader>st', function() Snacks.picker.todo_comments() end, desc = "[S]earch [T]odo" },
  }
}
