#!/usr/bin/env ruby
require 'under_fire'
require 'slop'
require 'pry'

include UnderFire

opts = Slop.parse do
  command 'search' do
    on :t, :album_title, "Album title", argument: :optional
    on :a, :artist, "Artist name", argument: :optional
    on :s, :track_title, "Song/track title", argument: :optional

    run do |opts, args|
      UnderFire.album_search(opts.to_hash)
    end
  end

  command 'toc' do
    run do |options, args|
      input = STDIN.read.chop
      toc = UnderFire.parse_discid_output(input)
      UnderFire.album_toc_search(toc).to_h
    end
  end
end

opts.to_hash(true)
