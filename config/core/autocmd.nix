{
  autoGroups = {
    "YankHighlight" = {clear = true;};
    "bufcheck" = {clear = true;};
    "large_buf" = {clear = true;};
    "close-with-q" = {clear = true;};
    "alpha_autostart" = {clear = true;};
    "wrap_spell" = {clear = true;};
    "terminal_settings" = {clear = true;};
    "UserLspConfig" = {};
  };
  autoCmd = [
    {
      event = "TextYankPost";
      group = "YankHighlight";
      pattern = "*";
      callback = {
        __raw = ''
          function()
            vim.highlight.on_yank({
              higroup = 'IncSearch',
              timeout = 40,
            })
          end
          '';
      };
    }
    {
      event = "TermEnter";
      group = "terminal_settings";
      callback = {
        __raw = ''function() vim.cmd("startinsert") end'';
      };
    }
    {
      event = "BufReadPost";
      group = "bufcheck";
      callback = {
        __raw = ''
          function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
              vim.fn.setpos('.', vim.fn.getpos("'\""))
              -- vim.cmd('normal zz') -- how do I center the buffer in a sane way??
              vim.cmd('silent! foldopen')
            end
          end
        '';
      };
    }
    {
      event = "Filetype";
      group = "close-with-q";
      pattern = [
        "PlenaryTestPopup"
        "help"
        "lspinfo"
        "man"
        "notify"
        "qf"
        "query"
        "spectre_panel"
        "startuptime"
        "tsplayground"
        "neotest-output"
        "checkhealth"
        "neotest-summary"
        "neotest-output-panel"
      ];
      callback = {
        __raw = ''
          function(data)
            vim.bo[data.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = data.buf, silent = true })
          end
        '';
      };
    }
    {
      event = "FileType";
      group = "wrap_spell";
      pattern = [
        "gitcommit" "markdown"
      ];
      callback = {
        __raw = ''
          function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end
        '';
      };
    }
    {
      event = "VimEnter";
      group = "alpha_autostart";
      callback = {
        __raw = ''
          function()
            local should_skip
            if
                vim.fn.argc() > 0
            then
              vim.cmd("wincmd l")
              vim.cmd("wincmd k")
              should_skip = true
            else
              for _, arg in pairs(vim.v.argv) do
                if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
                  should_skip = true
                  break
                end
              end
            end
            if should_skip then return end
          end
        '';
      };
    }
  ];
}