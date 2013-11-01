require_relative '../../spec_helper.rb'
require 'rr'

module UnderFire
  describe AlbumSearch do
    subject {AlbumSearch.new(artist: "Radiohead",
                             track_title: "Paranoid Android")}
    it "accepts a hash of arguments" do
      subject.artist.must_equal "Radiohead"
      subject.track_title.must_equal "Paranoid Android"
    end

    describe "#query" do
      it "returns the xml query" do
        subject.query.must_equal 'bim'
      end
    end
  end
end
