# Based on https://sandstorm.de/de/blog/post/my-first-steps-with-nix-on-mac-osx-as-homebrew-replacement.html

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, unstable }: {
    packages."aarch64-darwin".default = let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      unstablepkgs = import unstable { inherit system; config.allowUnfree = true; };
    in pkgs.buildEnv {
      name = "global-packages";
      paths = with pkgs; [
        # general CLI tools
        less
        bat
        jq
        jo
        yq-go
        cloc
        gawk
        unixtools.watch
        pv
        ripgrep
        gettext
        gnupg
        vim
        wdiff
        aspell
        gnused
        getopt
        htop
        coreutils
        moreutils
        brotli
        chezmoi

        # network
        wget
        curl
        ipcalc
        unstablepkgs.k6
        mkcert
        socat
        mtr
        inetutils
        websocat
        nss.tools               
        (cacert.overrideAttrs (oldAttrs: {
          postInstall = oldAttrs.postInstall or "" + ''
            echo "Regenerating ca-bundle.crt to workaround https://github.com/NixOS/nixpkgs/issues/283793"
            security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain >> $out/etc/ssl/certs/ca-bundle.crt
            security find-certificate -a -p /Library/Keychains/System.keychain >> $out/etc/ssl/certs/ca-bundle.crt
          '';
        }))

        # services
        postgresql_14
        redis

        # shell
        bash
        unstablepkgs.atuin
        tmux
        fzf
        shellcheck
        
        # VCS
        git
        delta
        gh

        # DevOps tools
        argo
        argocd
        argo-rollouts
        kubernetes-helm
        helmfile
        kubernetes-helmPlugins.helm-diff
        goreleaser
        goreman
        vault
        dive
        kind
        k9s
        kubelogin
        tfswitch
        # Out-of-date
        # terraform-landscape
        dyff

        # languages
        maven
        #gradle_7
        groovy
        go
        php
        php82Packages.composer
        nodejs_20
        (python3.withPackages(ps: with ps; [ packaging pip pyyaml ]))

        # AV
        ffmpeg
        imagemagick
      ];
    };
  };

}
