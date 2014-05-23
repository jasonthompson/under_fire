require_relative '../../spec_helper'
require 'under_fire/track'

module UnderFire
  describe Track do
    track_info = {:track_num => "5",
                  :gn_id => "3843674-5020FA6C0AD103AF757FC8F4DE56F179",
                  :title => "Money"}
    subject{Track.new(track_info)}

    describe 'title' do
      it "returns the title" do
        subject.title.must_equal "Money"
      end
    end

    describe 'gn_id' do
      it "must return the gracenote ID" do
        subject.gn_id.must_equal "3843674-5020FA6C0AD103AF757FC8F4DE56F179"
      end
    end

    describe 'track_number' do
      it 'must return the track number' do
        subject.track_number.must_equal 5
      end
    end
  end
end
