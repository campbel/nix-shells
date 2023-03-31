with import <nixpkgs> {};

let
    dotfiles=pkgs.fetchgit {
        url = "https://github.com/campbel/dotfiles.git";
        rev = "b40e8413346e5c2b18a64daa08aeda317b35bc78";
        sha256 = "0C4pt1fg7BX23fkBID89wZkFnDAvnWQxlh8cQmyozUY=";
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

