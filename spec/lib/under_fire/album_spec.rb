require_relative '../../spec_helper'
require 'under_fire/album'
require 'json'

module UnderFire
  describe Album do
    path = "../../../fixtures/album_response.json"
    file = File.open(File.expand_path(path, __FILE__))
    album_info = JSON.parse(file.read, opts = {:symbolize_names => true})
    subject{Album.new(album_info)}

    describe '#title' do
      it 'returns album title' do
        subject.title.must_equal 'The Dark Side Of The Moon'
      end
    end

    describe '#service_id' do
      it 'returns the correct id' do
        subject.gn_id.must_equal "3843669-A2F0933E54472E454B1888FFD34E64E5"
      end
    end

    describe '#artist' do
      it 'returns the correct artist' do
        subject.artist.must_equal "Pink Floyd"
      end
    end

    describe '#genre_name' do
      it 'returns the correct genre name' do
        subject.genre_name.must_equal "70's Rock"
      end
    end

    describe '#pkg_lang' do
      it 'returns the correct package language' do
        subject.pkg_lang.must_equal "ENG"
      end
    end

    describe 'date' do
      it 'returns the correct date' do
        subject.date.must_equal Date.new(1973)
      end
    end

    describe 'track_count' do
      it 'returns the correct track count' do
        subject.track_count.must_equal 9 
      end
    end

    describe 'tracks' do
      it 'returns an array of tracks' do
        subject.tracks.must_be_instance_of Array
      end

      it 'must have the correct number of tracks' do
        subject.tracks.count.must_equal 9
      end
    end
  end
end
