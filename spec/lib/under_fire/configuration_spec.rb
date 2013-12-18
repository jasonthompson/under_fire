require_relative '../../spec_helper'

module UnderFire
  describe Configuration do
    before do
      ENV['UF_CONFIG_PATH'] = File.expand_path('spec/fixtures/.ufrc')
      @config = UnderFire::Configuration.instance
    end

    it "has a client_id" do
      @config.client_id.must_equal "12345668"
    end

    it "has a user_id" do
      @config.user_id.must_equal "1432145345-13413554646D35134"
    end
  end
end
