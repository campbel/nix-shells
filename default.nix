with import <nixpkgs> {};

let
    dotfiles=pkgs.fetchgit {
        url = "https://github.com/campbel/dotfiles.git";
        rev = "72c4698029fcd932d5ba1c83e358b18d866a30c1";
        sha256 = "QsLkIOdXcmC9emMp0vNzPZn0jf/f7hJEsZPINNxi26E=";
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
        git -C "${dotfiles}" submodule update --init --recursive

        echo "[Linking dotfiles]"
        for i in "${dotfiles}"/dotfiles/*; do
            echo -e ".$(basename "$i")"
            [ -d ~/."$(basename "$i")" ] && rm -rf ~/."$(basename "$i")"
            ln -sf "$i" ~/."$(basename "$i")"
        done

        echo "[Linking config]
        mkdir -p ~/.config
        for i in "${dotfiles}"/config/*; do
            echo -e "$(basename "$i")"
            [ -d ~/.config/"$(basename "$i")" ] && rm -rf ~/.config/"$(basename "$i")"
            ln -sf "$i" ~/.config/"$(basename "$i")"
        done
        
        echo "[Setting environment variables]"
        export STARSHIP_CONFIG="~/.config/starship.nix.toml"
    '';
}

