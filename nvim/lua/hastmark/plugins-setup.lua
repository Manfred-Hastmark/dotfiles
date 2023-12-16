local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim")

  use("bluz71/vim-nightfly-guicolors")

  use("christoomey/vim-tmux-navigator")

  use("szw/vim-maximizer")

  use("tpope/vim-surround")
  use("vim-scripts/ReplaceWithRegister")

  use("numToStr/Comment.nvim")

  use("nvim-tree/nvim-tree.lua")

  -- icons
  use("kyazdani42/nvim-web-devicons")
  
  -- statusline
  use("nvim-lualine/lualine.nvim")

  use("nvim-telescope/telescope.nvim")

  use("neovim/nvim-lspconfig")

  use("rhysd/vim-clang-format")

  use("NvChad/nvterm")

  use {'neoclide/coc.nvim', branch = 'release'}

  if packer_bootstrap then
    require("packer").sync()
  end
end)
