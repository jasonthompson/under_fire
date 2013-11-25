require 'net/http'
require 'net/https'
require 'uri'
require 'open-uri'

module UnderFire
  class ApiRequest
    def self.post(query, api_url)
      uri = URI(api_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.ssl_version = 'SSLv3'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Post.new(uri.request_uri)
      req.body = query
      req['Content-Type'] = 'application/xml'
      res = http.request(req)
      res 
    end

    def self.get_file(url, filename)
      uri = URI url

      Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new uri
        
        http.request request do |response|
          open filename, 'w' do |io|
            response.read_body do |chunk|
              io.write chunk
            end
          end
        end
      end
    end
  end
end
