{ pkgs, config, ...}:
let 
  inherit (config) colorscheme;
in
{
  home.sessionVariables.COLORTERM = "truecolor";
  home.sessionVariables.EDITOR = "hx";
  home.sessionVariables.VISUAL= "hx";
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        color-modes = true;
        line-number = "relative";
        indent-guides.render = true;
        bufferline = "multiple";
        cursor-shape = {
         normal = "block";
         insert = "bar";
         select = "underline";
        };
      };
    };
    themes = import ./theme.nix { inherit colorscheme; };
    languages = {
      language = [
          {
            name = "nix";
            language-server = {
              command = "${pkgs.nixd}/bin/nixd";
            };
          }
      ];
        
        
    };
  };

  home.packages = with pkgs; [
     shellcheck
     nixd
     cbqn
  ];
}
