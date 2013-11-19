require_relative '../../spec_helper.rb'
require 'rr'

module UnderFire
  describe AlbumSearch do

    subject {AlbumSearch.new(artist: "Radiohead",
                             track_title: "Paranoid Android",
                             album_title: "OK Computer")}

    before do
          ENV['GRACENOTE_CLIENT_ID'] = '1234454'
          ENV['GRACENOTE_USER_ID'] = '2353452345243545-454351435kj435j345434'
    end

    it "accepts a hash of arguments" do
      subject.artist.must_equal "Radiohead"
      subject.track_title.must_equal "Paranoid Android"
    end

    describe "#query with all fields" do
      it "returns the correct xml query" do
        subject.query.must_include "Radiohead"
      end
    end

    describe "#mode" do
      it "accepts a search mode on instantiation" do
        AlbumSearch.new(artist: "Radiohead", mode: "FOO").mode.must_equal "FOO"
      end
    end
      
    describe "#query with artist" do
      subject{AlbumSearch.new(artist: "Radiohead")}
      it "returns an xml query with an artist name" do
        subject.query.must_include "Radiohead"
      end

      it "does not return album_title or track_title fields" do
        subject.query.wont_include "TRACK_TITLE"
        subject.query.wont_include "ALBUM_TITLE"
      end
    end
  end
end
