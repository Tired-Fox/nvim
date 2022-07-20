-- https://github.com/norcalli/nvim-colorizer.lu

require 'colorizer'.setup ({
  '*'; -- Highlight all files, but customize some others.
  css = { mode='background', rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  scss = { mode='background', rgb_fn = true; };
  sass = { mode='background', rgb_fn = true; };
  html = { names = false; }; -- Disable parsing "names" like Blue or Gray
  lua = { names = false; };
  "!packer";
}, { mode = 'foreground'})
-- #12e42a
-- Can exlude file type with a `!` in front of the filetype
