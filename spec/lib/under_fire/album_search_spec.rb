require_relative '../../spec_helper.rb'
require 'rr'

module UnderFire
  describe AlbumSearch do
    subject {AlbumSearch.new(artist: "Radiohead",
                             track_title: "Paranoid Android",
                             album_title: "OK Computer")}
    let(:xml){
      '<queries><auth><client>1234454</client>'+
      '<user>2353452345243545-454351435kj435j345434</user></auth>'+
      '<lang>eng</lang><country>canada</country>'+
      '<query cmd="ALBUM_SEARCH">'+
      '<text type="ALBUM_TITLE">OK Computer</text>'+
      '<text type="TRACK_TITLE">Paranoid Android</text>'+
      '<text type="ARTIST">Radiohea</text>'+
      '</query></queries>'
    }

    before do
          ENV['GRACENOTE_CLIENT_ID'] = '1234454'
          ENV['GRACENOTE_USER_ID'] = '2353452345243545-454351435kj435j345434'
    end

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
