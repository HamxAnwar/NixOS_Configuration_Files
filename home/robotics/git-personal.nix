{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "HamxAnwar";
    userEmail = "hamzaanwar93@outlook.com";
    signing = {
      key = "pub file location";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      color.ui = "auto";
      core.editor = "hx";
      gpg.format = "ssh";
      commit.gpgSign = false;
      user.signingKey = "pub file location";
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
        identityFile = "private ssh file location";
      };
    };
  };
  services.ssh-agent.enable = true;
}
