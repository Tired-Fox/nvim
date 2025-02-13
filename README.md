**Install Neovim v10+ with Scoop**

- Run `scoop install neovim`
- Check that it is `v10+` with `nvim --version`

**Install @vue/typescript-plugin**

This plugin is needed for the typescript/javascript langauge server to run with the vue language server.

- Run `npm install -g @vue/typescript-pugin`

**Install Precompiled Treesitter Parsers**

This will give you access to basic code highlighting, jump lists, etc. Better to use the precompiled version vs making your neovim compile over 250 parsers and exploding.

- Download: https://github.com/anasrar/nvim-treesitter-parser-bin/releases/download/windows/all.zip
- Unzip contents to: `%localappdata%/nvim-data/lazy/nvim-treesitter/parser`

**Define Java Executables**

The java language server runs with a java v17+ instance and can have runtimes of any other version.
To define these versions open `after/ftplugin/java.lua` and edit the lines marked with `java-path` in a comment.

To change the runtime used while the neovim instance is open run the command `:lua JavaRuntimes()`. This can only be run when you have opened at least one `java` file

**Tips**

- Use `:Telescope keymaps` with `<C-n>` and `<C-p>`, or arrow keys, to view all the keymaps.
