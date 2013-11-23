module UnderFire
  module CLI
    
  commands_list = %Q(COMMANDS:
            album: Search for an album using artist, album title or track title.
            toc:   Use CD table of contents to find album information.)

  help_message = %Q(usage: under-fire [-h, --help] [-v, --version] [-l, --list]
                   <command> [-h, --help] [<args>]

                   List available commands: under-fire -l
                   Get help for a command: under-fire <command> [-h, --help]\n\n)

  album_help_message = %Q(usage: under-fire album [-a, --artist]
                        [-t, --album_title] [-s, --song_title]
                        [-m, --mode [SINGLE_BEST | SINGLE_BEST_COVER]]\n\n)
  end
end
