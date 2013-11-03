module UnderFire
  module Configuration
    def client_id
      ENV['GRACENOTE_CLIENT_ID']
    end

    def client_tag
      tag, _ = client_id.split('-')
      tag
    end

    def user_id
      ENV['GRACENOTE_USER_ID']
    end

    def user_id
      ENV['GRACENOTE_USER_ID']
    end

    def api_url
      "https://c#{client_tag}.web.cddbp.net/webapi/xml/1.0/"
    end

    module_function :client_id, :client_tag, :api_url, :user_id
  end
end
