{...}: {
  programs.vesktop = {
    enable = true;
    settings = {
      arRPC = true;
      checkUpdates = false;
      discordBranch = "canary";
      disableMinSize = true;
      splashBackground = "#1e1e2e";
      splashColor = "#cba6f7";
      splashTheming = true;
      tray = false;
      minimizeToTray = false;
    };

    vencord = {
      themes = {
        catppuccin-mocha-mauve = builtins.fetchurl {
          url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css";
          sha256 = "166p8y939zhrgpvdh91bqmv433r13jac4v1hwwszaz0ndqpisn8k";
        };
      };
      settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        plugins = {
          AlwaysTrust.enabled = true;
          BetterFolders.enabled = true;
          BetterSessions.enabled = true;
          BetterSettings = {
            enabled = true;
            disableFade = false;
          };
          BlurNSFW.enabled = true;
          CallTimer.enabled = true;
          ClearURLS.enabled = true;
          ConsoleJanitor.enabled = true;
          Dearrow.enabled = true;
          FakeNitro.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          GameActivityToggle.enabled = true;
          HideMedia.enabled = true;
          iLoveSpam.enabled = true;
          ImageZoom.enabled = true;
          LoadingQuotes.enabled = true;
          MemberCount.enabled = true;
          MessageLinkEmbeds.enabled = true;
          MessageLogger.enabled = true;
          MoreCommands.enabled = true;
          MoreKaomoji.enabled = true;
          Moyai.enabled = true;
          NoDevtoolsWarning.enabled = true;
          NoF1.enabled = true;
          NoOnboardingDelay.enabled = true;
          NoPendingCount.enabled = true;
          NoTypingAnimation.enabled = true;
          oneko.enabled = true;
          OnePingPerDM.enabled = true;
          OpenInApp.enabled = true;
          PermissionsViewer.enabled = true;
          petpet.enabled = true;
          PlainFolderIcon.enabled = true;
          PlatformIndicators.enabled = true;
          RelationshipNotifier.enabled = true;
          SendTimestamps.enabled = true;
          ShikiCodeBlocks.enabled = true;
          ShowHiddenChannels.enabled = true;
          ShowHiddenThings.enabled = true;
          SilentTyping.enabled = true;
          SpotifyControls.enabled = true;
          SpotifyCrack.enabled = true;
          SpotifyShareCommands.enabled = true;
          Unindent.enabled = true;
          UserMessagesPronouns.enabled = true;
          ValidReply.enabled = true;
          ValidUser.enabled = true;
          VolumeBooster.enabled = true;
          YoutubeAdblock.enabled = true;
        };
        enabledThemes = ["catppuccin-mocha-mauve.css"];
      };
    };
  };
}
