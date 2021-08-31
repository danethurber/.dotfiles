local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local trouble = require("trouble.providers.telescope")

telescope.setup({
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8
      },
      vertical = {
        mirror = false
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120
    },
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
    prompt_prefix = "   ",
  },
})

if
  not pcall(
    function()
      telescope.load_extension("fzf")
      telescope.load_extension("media_files")
    end
  )
then
  -- This should only trigger when in need of PackerSync, so better do it
  print("After completion of PackerSync, restart neovim.")

  -- Trigger packer compile on PackerComplete, so it properly waits for PackerSync
  vim.cmd 'autocmd User PackerComplete ++once lua require("packer").compile()'
  require("packer").sync("telescope-fzf-native.nvim", "telescope-media-files.nvim")
end
