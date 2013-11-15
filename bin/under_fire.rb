#!/usr/bin/env ruby
require 'under_fire'
require 'slop'
require 'pry'

extend UnderFire

module UnderFire
  help_message = %Q(usage: under-fire [-h, --help] [-v, --version] [-l, --list]
                   <command> [-h, --help] [<args>]
                   List available commands with under-fire -l.)

  opts = Slop.parse(strict: true) do
    banner 'Usage: under-fire'

    on :v, :verbose, 'Print the version' do
      puts UnderFire::VERSION
    end

    on 'default' do
      puts help_message
    end

    on :l, :list do
      puts %Q(COMMANDS:
  album: Search for an album using artist, album title or track title.
  toc:   Use CD table of contents to find album information.)
    end

    command 'album' do
      on :t, :album_title, "Album title", argument: :optional
      on :a, :artist, "Artist name", argument: :optional
      on :s, :track_title, "Song/track title", argument: :optional
      on :h, :help, "Print help message" do
        puts %Q(usage: under-fire album [-h, --help] [-t, --album_title]
                  [-a, --artist] [-s, --trac_title])
        exit
      end

      run do |opts|
        params = {album_title: opts[:album_title],
                  track_title: opts[:track_title],
                  artist: opts[:artist]}
        UnderFire.album_search(params)
      end
    end

    command 'toc' do
      on :t, :toc, "Table of contents", argument: :optional

      on :h, :help do
        puts "under-fire toc <toc offsets for each track>"
        exit
      end

      run do |opts|
        puts opts[:toc]
        toc = UnderFire.parse_discid_output(opts[:toc])

        #nderFire.album_toc_search(toc).to_h
      end
    end


  end

  opts.to_hash(true)

  rescue Slop::Error => e
    puts e.message
    puts help_message
    exit
end
