#!/usr/bin/env ruby
require 'under_fire'
require 'slop'
require 'pry'

extend UnderFire

module UnderFire

  commands_list = %Q(COMMANDS:
            album: Search for an album using artist, album title or track title.
            toc:   Use CD table of contents to find album information.)

  help_message = %Q(usage: under-fire [-h, --help] [-v, --version] [-l, --list]
                   <command> [-h, --help] [<args>]

                   List available commands: under-fire -l
                   Get help for a command: under-fire <command> [-h, --help]\n\n)

  album_help_message = %Q(usage: under-fire album [-a, --artist] 
                        [-t, --album_title] [-s, --song_title]\n\n)

  opts = Slop.parse(strict: true) do
    if ARGV.empty?
      puts " under-fire expects an option or a command: \n\n #{help_message}"
    end

    on :h, :help do
      puts help_message
    end

    on :l, :list do
      puts 
    end

    command 'album' do
      on :t, :album_title, "Album title", argument: :optional
      on :a, :artist, "Artist name", argument: :optional
      on :s, :track_title, "Song/track title", argument: :optional
      on :h, :help, "Print help message" do
        puts album_help_message
        exit
      end

      run do |opts|
        params = opts.to_h.reject {|k,v| v.nil?}

        if params.empty?
           puts "\n'under-fire album' requires at least one argument.\n\n" +
             help_message
           exit
         end
        UnderFire.album_search(params).to_s
      end
    end

    command 'toc' do
      run do
        UnderFire.album_toc_search.to_s
      end
    end
  end

  opts.to_hash(true)

  rescue Slop::InvalidOptionError => e
    puts e.message
    puts help_message
    exit
end
