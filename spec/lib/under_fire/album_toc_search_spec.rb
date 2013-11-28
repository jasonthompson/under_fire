require_relative '../../spec_helper.rb'
require 'rr'
require 'ox'

module UnderFire
  describe AlbumTOCSearch do
    let(:toc){"182 10762 22515 32372 43735 53335 63867 78305 89792 98702"+
        "110612 122590 132127 141685"}
    subject {AlbumTOCSearch.new(toc)}

    let(:xml){
      '<queries><auth><client>1234454</client>'+
      '<user>2353452345243545-454351435kj435j345434</user></auth>'+
      '<lang>eng</lang><country>canada</country>'+
      '<query cmd="ALBUM_TOC">'+
      '<mode>SINGLE_BEST_COVER</mode>'+
      '<toc><offsets>' + toc + '</offsets></toc>'+
      '</query></queries>'}

    before do
          ENV['GRACENOTE_CLIENT_ID'] = '1234454'
          ENV['GRACENOTE_USER_ID'] = '2353452345243545-454351435kj435j345434'
    end


      it "accepts a toc string" do
        subject.toc.must_equal toc
      end


    describe "#query" do
      it "returns the correct xml query" do
        q = Ox.load(subject.query)
        q.nodes[3].nodes[1].value.must_equal "toc"
        q.nodes[3].nodes[1].nodes[0].nodes[0].must_include "182"
        q.nodes[3].nodes[1].nodes[0].nodes[0].must_include "141685"
      end
    end
  end
end
