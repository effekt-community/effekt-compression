{
  description = "Data compression algorithms in Effekt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    effekt-nix = {
      url = "github:jiribenes/effekt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows ="flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, effekt-nix }:
    ## If you want only some specific systems, do the following instead:
    # flake-utils.lib.eachSystem ["aarch64-linux" "aarch64-darwin"] (system:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        effekt-lib = effekt-nix.lib.${system};

        ## Project configuration
        pname = "compression-effekt";         # package name
        version = "0.1.0";                 # package version
        mainFile = "src/compress.effekt";      # relative path to entrypoint (as a string)
        testFiles = [ "src/test.effekt" ]; # relative paths to tests (as a string)

        ## Effekt configuration
        effektConfig = {
          ## Uncomment and set a specific version if needed:
          # version = "0.10.0";

          ## Select the backends that your project works on:
          backends = with effekt-lib.effektBackends; [ js llvm ];
        };

        # Chooses the correct Effekt package.
        effektBuild = effekt-lib.getEffekt effektConfig;
      in {
        packages.default = effekt-lib.buildEffektPackage {
          inherit pname version;
          src = ./.;
          main = mainFile;
          tests = testFiles;

          effekt = effektBuild;
          inherit (effektConfig) backends;
        };

        devShells.default = effekt-lib.mkDevShell {
          effekt = effektBuild;
        };

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.default;
          name = pname;
        };
      }
    );
}
