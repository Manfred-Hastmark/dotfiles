local function get_relative_path()
  -- Get the full file path of the current buffer
  local file_path = vim.api.nvim_buf_get_name(0)
  
  -- If there's no file path (e.g., an unsaved buffer), return an empty string
  if file_path == "" then
    return ""
  end

  -- Get the relative path from the current working directory
  return vim.fn.fnamemodify(file_path, ":.")
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
        'nvim-tree/nvim-web-devicons' 
    },
    config = function()
        require('lualine').setup{
            options = {
                theme = 'ayu_mirage'
            },
            sections = {
                lualine_a = {'progress'},
                lualine_b = {'diagnostics'},
                lualine_c = {get_relative_path},
                lualine_x = {'location'},
                lualine_y = {'branch'},
                lualine_z = {'diff'},
            },
        }
    end,
}
