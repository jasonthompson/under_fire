require 'under_fire/album_search'
require 'under_fire/album_toc_search'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/configuration'

require 'pry'

module UnderFire
  class Client
    include UnderFire

    attr_reader :api_url

    def initialize
      @api_url = Configuration.api_url
    end

    def find_by_toc
      search = AlbumTocSearch.new(get_toc)
      response = ApiRequest.post(search.query, api_url)
      ApiResponse.new(response.body)
    end

    def find_album(args)
      search = AlbumSearch.new(args)
      response = ApiRequest.post(search.query, api_url)
      ApiResponse.new(response.body)
    end

    def fetch_cover(response)
      res = response.to_h
      response_url = res['RESPONSE']['ALBUM']['URL']
      title = res['RESPONSE']['ALBUM']['TITLE']
      ApiRequest.get_file(response_url, "#{title}-cover.jpeg")
    end

    private

    def get_toc(discid=`discid`)
      discid.split[2..-2].join " "
    end
  end
end
