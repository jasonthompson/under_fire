require_relative '../../spec_helper'
require 'under_fire/song.rb'

module UnderFire
  describe Track do
    track = {:track_num => "5",
             :gn_id => "3843674-5020FA6C0AD103AF757FC8F4DE56F179",
             :title => "Money"}
    subject{Track.new(track_info)} 

  end
end
