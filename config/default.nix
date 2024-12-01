{pkgs, ...}: {
  # Import all your configuration modules here
  imports = [
    ./core
    ./themes
    ./plugins
  ];
  viAlias = true;
  vimAlias = true;
  clipboard = {
    register = "unnamedplus";
    providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };
  };
  globals.mapleader = " ";

  # Misc plugins
  plugins = {
    persistence = {
      enable = true;
      saveEmpty = true;
      preSave = ''
        function()
          -- remove dir buffers and buffers whose files are located outside of cwd
          local cwd = vim.fn.getcwd() .. '/'
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local bufpath = vim.api.nvim_buf_get_name(buf) .. '/'
            if not bufpath:match('^' .. vim.pesc(cwd)) then
              vim.api.nvim_buf_delete(buf, {})
            end
          end
        end'';
      options = [
        "buffers"
        "curdir"
        "tabpages"
        "winsize"
        "skiprtp"
        "winpos"
        "terminal"
        "folds"
        "resize"
        "globals"
        "options"
        "localoptions"
        "sesdir"
        "help"
      ];
    };
    web-devicons.enable = true;
    lastplace.enable = true;
    nvim-autopairs.enable = true;
    markdown-preview.enable = true;
    tmux-navigator.enable = true;
    zellij = {
      enable = true;
      settings = {
        vimTmuxNavigatorKeybinds = true;
      };
    };
    better-escape = {
      enable = true;
      settings.timeout = 200;
    };
    which-key = {
      enable = false; # If you want to enable then change timeoutLen to 10 in core/options.nix for better performance
      settings.show_keys = true;
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    vim-be-good
    nui-nvim
  ];
  extraPackages = with pkgs; [
    # ripgrep
    tmux-sessionizer
    # Formatters
    alejandra
    asmfmt
    astyle
    black
    cmake-format
    gofumpt
    golines
    gotools
    isort
    nodePackages.prettier
    prettierd
    rustfmt
    shfmt
    stylua
    # Debuggers / misc deps
    asm-lsp
    bashdb
    clang-tools
    delve
    fd
    gdb
    go
    lldb_17
    llvmPackages_17.bintools-unwrapped
    marksman
    # Linters
    commitlint
    # eslint_d
    golangci-lint
    hadolint
    # html-tidy
    luajitPackages.luacheck
    markdownlint-cli
    nodePackages.jsonlint
    pylint
    ruff
    # shellcheck
    vale
    yamllint
  ];
}
