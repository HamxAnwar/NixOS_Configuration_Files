{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "HamxAnwar";
    userEmail = "hamzaanwar93@outlook.com";
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      color.ui = "auto";
      core.editor = "Text/Code Editor";
      gpg.format = "ssh";
      commit.gpgSign = false;
      user.signingKey = "~/.ssh/id_ed25519.pub";
      alias = {
        co = "checkout";
        br = "branch";
        st = "status";
        cm = "commit -m";
        lg = "log --oneline --graph --decorate --all";
      };
    };
  };
    
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
  services.ssh-agent.enable = true;
}
