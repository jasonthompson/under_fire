require_relative '../../spec_helper'
require_relative '../../../lib/under_fire/configuration'

module UnderFire
  describe Configuration do
    before do
      ENV["GRACENOTE_CLIENT_ID"] = "12345668"
      ENV["GRACENOTE_USER_ID"] = "1432145345-13413554646D35134"
      @obj_with_configuration = Object.new.tap do |obj|
        obj.extend Configuration
      end
    end

    it "has a client_id" do
      Configuration.client_id.must_equal "12345668"
    end

    it "has a user_id" do
      Configuration.user_id.must_equal "1432145345-13413554646D35134"
    end
  end
end
