{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Your Name Here";
    userEmail = "your.email@example.com";
    signing = {
      key = "~/.ssh/demo_ed25519.pub";
      signByDefault = false;
    };

    services.ssh-agent.enable = true;

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          user = "git";
          identityFile = "~/.ssh/demo_ed25519";
        };
      };
    };


    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      color.ui = "auto";
      core.editor = "Text/Code Editor";
      gpg.format = "ssh";
      commit.gpgSign = false;
      user.signingKey = "~/.ssh/demo_ed25519.pub";
      alias = {
        co = "checkout";
        br = "branch";
        st = "status";
        cm = "commit -m";
        lg = "log --oneline --graph --decorate --all";
      };
    };
  };
}
