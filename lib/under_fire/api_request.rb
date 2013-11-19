require 'net/http'
require 'net/https'
require 'uri'

module UnderFire
  class ApiRequest
    def self.post(query)
      uri = URI(UnderFire::Configuration.api_url)
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
      require 'open-uri'

      File.open(filename, "wb") do |saved_file|
        open(url, 'rb') do |read_file|
          saved_file.write(read_file.read)
        end
      end
    end
  end
end
