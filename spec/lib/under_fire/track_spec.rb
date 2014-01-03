require_relative '../../spec_helper'
require 'under_fire/track'

module UnderFire
  describe Track do
    describe 'instantiation' do
      it 'must instantiate with correct track info' do
        track = Track.new(:track_num => 1,
                          :gn_id => '86372322-05CF584F3265FA67F3E0C18987973C21',
                          :title => 'Help!')
        track.title.must_equal 'Help!'
      end
    end
  end
end
