require 'singleton'

module UnderFire
  # Configuration information.
  class Configuration
    include Singleton

    attr_reader :path

    attr_reader :config_info

    CONFIG_FILE_NAME = '.ufrc'

    def initialize
      @path = File.join(File.expand_path('~'), CONFIG_FILE_NAME)
      @config_info = load_config
    end

    # Gracenote client id stored in environment variable.
    # @return [String]
    def client_id
      config_info.fetch("client_id", nil).to_s
    end

    # Set client_id
    # @param [String]
    def client_id=(id)
      config_info['client_id'] = id.to_s
      write_config
    end

    # Part of client id before the hyphen (used by api_url).
    # @return [String]
    def client_id_string
      ci_string, _ = config_info['client_id'].split('-')
      ci_string
    end

    # Part of client id after hyphen
    # @return [String]
    def client_tag
      _, ct = config_info['client_id'].split('-')
      ct
    end

    # Gracenote user id 
    # @return [String]
    def user_id
      config_info.fetch('user_id', nil).to_s
    end

    # Set user_id
    # @param [String]
    def user_id=(id)
      config_info['user_id'] = id.to_s
      write_config
    end

    # Gracenote API url for use in queries.
    # @return [String]
    def api_url
      "https://c#{client_id_string}.web.cddbp.net/webapi/xml/1.0/"
    end

    def authorized?
      user_id != nil
    end

    def configured?
      client_id != nil && !authorized?
    end

    def reset
      initialize
    end

    # Set path for configuration file
    # @param [String || File]
    def path=(config_path)
      @path = config_path
      @config_info = load_config
      write_config
    end

    private

    def load_config
      require 'yaml'
      YAML.load_file(path)
      rescue Errno::ENOENT
       {}
    end

    def write_config
      require 'yaml'
      File.open(path, File::CREAT|File::RDWR) do |f|
        f.write config_info.to_yaml
      end
    end
  end
end
