require_relative '../../spec_helper'

module UnderFire
  describe Configuration do
    before do
      ENV['GRACENOTE_CLIENT_ID'] = "12345668"
      ENV['GRACENOTE_USER_ID'] = "1432145345-13413554646D35134"
    end

    it "has a client_id" do
      UnderFire::Configuration.client_id.must_equal "12345668"
    end

    it "has a user_id" do
      UnderFire::Configuration.user_id.must_equal "1432145345-13413554646D35134"
    end
  end
end
