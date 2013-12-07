module UnderFire
  module Configuration
    # Gracenote client id stored in environment variable.
    # @return [String]
    def client_id
      ENV['GRACENOTE_CLIENT_ID']
    end

    # Part of client id before the hyphen (used by api_url).
    # @return [String]
    def client_id_string
      ci_string, _ = ENV['GRACENOTE_CLIENT_ID'].split('-')
      ci_string
    end


    def client_tag
      _, ct = ENV['GRACENOTE_CLIENT_ID'].split('-')
      ct
    end

    # Gracenote user id stored as environment variable.
    # @return [String]
    def user_id
      ENV['GRACENOTE_USER_ID']
    end

    # Gracenote API url for use in queries.
    # @return [String]
    def api_url
      "https://c#{client_id_string}.web.cddbp.net/webapi/xml/1.0/"
    end

    module_function :client_id, :client_tag, :api_url, :user_id,
                    :client_id_string
  end
end
