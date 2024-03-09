{
  keymaps = [
    {
      mode = "n";
      action = "<cmd>NvimTreeFindFileToggle<CR>";
      key = "<C-n>";
      options = {
        silent = true;
      };
    }
  ];
  plugins = {
    nvim-tree = {
      enable = true;
      autoClose = true;
      openOnSetup = true;
      view = {
        side = "left";
        signcolumn = "no";
        preserveWindowProportions = true;
        float = {
          openWinConfig = {
            col = 1;
            row = 1;
            relative = "editor";
            border = "rounded";
            #style = "minimal";
          };
        };
      };
    };
  };
}