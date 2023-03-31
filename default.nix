with import <nixpkgs> {};

let
    dotfiles=pkgs.fetchgit {
        url = "https://github.com/campbel/dotfiles.git";
        rev = "72c4698029fcd932d5ba1c83e358b18d866a30c1";
        sha256 = "MWoEn94FkkxZoFCtw2WqTfkRMYO3H2BTFGq3LFPpyfE=";
    };
in

stdenv.mkDerivation {
    name = "campbel-shell";
    buildInputs = [
        bat
        curl
        git
        jq
        go_1_20
        zsh
        starship
        vim
    ];
    shellHook = ''
        echo "Linking dotfiles..."
        mkdir -p ~/.config
        ln -sf ${dotfiles}/config/starship.nix.toml ~/.config/starship.toml
        ln -sf ${dotfiles}/dotfiles/zshrc ~/.zshrc
        ln -sf ${dotfiles}/dotfiles/zprofile ~/.zprofile
    '';
}

