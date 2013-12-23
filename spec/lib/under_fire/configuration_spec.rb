require_relative '../../spec_helper'
require 'pry'

module UnderFire
  describe Configuration do
    let(:base_dir){File.expand_path(__FILE__ + "/../../..")}
    let(:config_file){File.join(base_dir, 'fixtures/.ufrc')}

    after do
      Configuration.instance.reset
    end

    describe "a completed configuration" do

      it "has a client_id" do
        config = Configuration.instance
        config.path = config_file
        config.client_id.must_equal "1252545-34543523452345"
      end

      it "has a user_id" do
        config = Configuration.instance
        config.path = config_file
        puts config.path
        config.user_id.must_equal "12354534"
      end

      describe "#path" do
        it "displays the config_file path" do
          tmp_ufrc = File.join(Dir.mktmpdir, '.ufrc')
          config = Configuration.instance
          config.path = tmp_ufrc
          config.path.must_equal tmp_ufrc
        end

        it "defaults to ~/.ufrc" do
          config = Configuration.instance
          config.path.must_equal File.join(File.expand_path('~'), '.ufrc')
        end
      end
    end

    describe "unconfigured" do
      describe "#configured?" do
        it "returns false if there are no credentials" do
          tmp_ufrc = File.join(Dir.mktmpdir, ".ufrc")
          config = Configuration.instance
          config.path = tmp_ufrc
          config.configured?.must_equal false
        end

        describe "#client_id=" do
          it "saves setting to file when set" do
            tmp_ufrc = File.join(Dir.mktmpdir, ".ufrc")
            config = Configuration.instance
            config.path = tmp_ufrc
            config.client_id = 'xyz'
            YAML.load_file(tmp_ufrc)['client_id'].must_equal "xyz"
          end
        end

        describe "#user_id=" do
          it "saves setting to file when set" do
            tmp_ufrc = File.join(Dir.mktmpdir, ".ufrc")
            config = Configuration.instance
            config.path = tmp_ufrc
            config.user_id = 'abadfadsf134234'
            YAML.load_file(tmp_ufrc)['user_id'].must_equal 'abadfadsf134234'
          end
        end
      end
    end
  end
end
