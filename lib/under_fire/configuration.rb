require 'singleton'

module UnderFire
  # Configuration information.
  class Configuration
    include Singleton

    attr_accessor :path

    attr_reader :config_info

    CONFIG_FILE_NAME = '.ufrc'

    def initialize
      @path = ENV['UF_CONFIG_PATH'] || File.join(File.expand_path('~'), CONFIG_FILE_NAME)
      @config_info = load_config
    end

    # Gracenote client id stored in environment variable.
    # @return [String]
    def client_id
      config_info["client_id"]
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

    # Gracenote user id stored as environment variable.
    # @return [String]
    def user_id
      config_info['user_id']
    end

    # Gracenote API url for use in queries.
    # @return [String]
    def api_url
      "https://c#{client_id_string}.web.cddbp.net/webapi/xml/1.0/"
    end

    def load_config
      require 'yaml'
      YAML.load_file(@path)
#    rescue Errno::ENOENT
#      {}
    end

    private
    def write_config
      require 'yaml'
      File.open(@path, File::RDWR | File::CREATE, 0600) do |f|
        f.write @data.to_yaml
      end
    end
  end
end
