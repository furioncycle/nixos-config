{inputs ,... }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}' or
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake: (flake.legacyPackages or flake.packages or { }).${final.system} or { })
      inputs;
  };

  # Adds my custom packages
  additions = final: prev: import ../pkgs { pkgs = final; } // {
    formats = prev.formats // import ../pkgs/formats { pkgs = final; };
  };

  # Modifies existing packages
  modifications = final: prev: {

    xdg-utils-spawn-terminal = addPatches prev.xdg-utils [ ./xdg-open-spawn-terminal.diff ];

    pfetch = prev.pfetch.overrideAttrs ({
      version = "unstable-2021-12-10";
      src = final.fetchFromGitHub {
        owner = "dylanaraps";
        repo = "pfetch";
        rev = "a906ff89680c78cec9785f3ff49ca8b272a0f96b";
        sha256 = "sha256-9n5w93PnSxF53V12iRqLyj0hCrJ3jRibkw8VK3tFDvo=";
      };
      # Add term option, rename de to desktop, add scheme option patches = (oldAttrs.patches or [ ]) ++ [ ./pfetch.patch ];
    });


  };
}
