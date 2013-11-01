require_relative '../../spec_helper.rb'
require 'rr'

module UnderFire
  describe AlbumSearch do
    before do
      # api_request = Object.new
      # mock(api_request).post()
    end
    
    describe "#find" do
      it "takes an :album_title" do
        AlbumSearch.new(album_title: "OK Computer").must_not_be_nil
      end
    end
  end
end
