require_relative '../../spec_helper.rb'
require 'nori'

module UnderFire
  describe APIResponse do
    let(:file_name){"../../../fixtures/response-track-search-multiple-album.xml"}
    let(:no_album_file){"../../../fixtures/response-no-listings.xml"}
    let(:res){File.open(File.expand_path file_name, __FILE__) {|f| f.read}}
    let(:response_no_albums){File.open(File.expand_path (no_album_file), __FILE__){|f| f.read}}
    subject{APIResponse.new(res)}

    describe "#parse_response" do
      it "returns a Hash" do
        subject.to_h.must_be_kind_of Hash
      end
    end

    describe "#success?" do
      it "returns true if response status is 'OK'" do
        subject.success?.must_equal true
      end
    end

    describe "#albums?" do
      it "returns true if response has album listings" do
        subject.albums?.must_equal true 
      end
    end

    describe "#album_count" do
      it "returns the number of album listings in response" do
        subject.album_count.must_equal 8
      end

      it "returns 0 if there are no album listings in response" do
        no_albums = APIResponse.new(response_no_albums)
        no_albums.album_count.must_equal 0
      end
    end

    describe "#ablums" do
      it "returns an Array" do
        subject.albums.must_be_kind_of Array
      end

      it "returns an Array of one or more Albums" do
        subject.albums[0].must_be_kind_of UnderFire::Album
      end
    end
  end
end
