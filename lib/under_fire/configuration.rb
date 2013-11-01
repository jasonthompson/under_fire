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

    def api_url
      "https://c#{client_tag}.web.cddbp.net/webapi/xml/1.0/"
    end
  end
end
