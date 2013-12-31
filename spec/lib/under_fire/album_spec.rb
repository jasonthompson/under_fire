require_relative '../../spec_helper'

module UnderFire
  describe Album do
    subject{Album.new(:gn_id=>"69444742-47B38D99C8A8BFDF9D3442B092E8B9DD",
                      :artist=>"Pink Floyd",
                      :title=>"Dark Side Of The Moon",
                      :pkg_lang=>"ENG",
                      :date=>"1973",
                      :genre=>"70's Rock",
                      :track_count=>"8",
                      :track => [{:track_num=>"1",
                                   :gn_id=>"69444743-1CAE74FE3966A64569470C499763CB71",
                                   :title=>"Speak To Me/Breathe"},
                                  {:track_num=>"2",
                                   :gn_id=>"69444744-8C0536A6E2597E45BA58EED9AE75932A",
                                   :title=>"On The Run"},
                                  {:track_num=>"3",
                                   :gn_id=>"69444745-11FC859B0BD5541D332402F1A140ABCC",
                                   :title=>"Time"},
                                  {:track_num=>"4",
                                   :gn_id=>"69444746-C1FD5D5734605CC33DF737A3F6E974BE",
                                   :title=>"The Great Gig In The Sky"},
                                  {:track_num=>"5",
                                   :gn_id=>"69444747-9FA0734A55C5643A2A809090D4A01ABF",
                                   :title=>"Money"},
                                  {:track_num=>"6",
                                   :gn_id=>"69444748-D0507B25B29685B8CB9C4CBF46025A4D",
                                   :title=>"Us And Them"},
                                  {:track_num=>"7",
                                   :gn_id=>"69444749-C7F5DF6A7A20DA9DF1998499D92B5B42",
                                   :title=>"Any Colour You Like"},
                                  {:track_num=>"8",
                                   :gn_id=>"69444750-B551266BFAE2641B60789E13FB97F4BF",
                                   :title=>"Brain Damage/Eclipse"}])}

    describe "#tracks" do
      it "must be a list of tracks" do
        subject.tracks.count.must_equal 8 
      end
    end
  end
end
