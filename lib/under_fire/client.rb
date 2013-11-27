require 'under_fire/album_search'
require 'under_fire/album_toc_search'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/configuration'
require 'under_fire/toc_reader'

require 'pry'

module UnderFire
  class Client
    include UnderFire

    attr_reader :api_url

    def initialize
      @api_url = Configuration.api_url
    end

    def find_by_toc
      search = AlbumTOCSearch.new(get_toc)
      response = APIRequest.post(search.query, api_url)
      APIResponse.new(response.body)
    end

    def find_album(args)
      search = AlbumSearch.new(args)
      response = APIRequest.post(search.query, api_url)
      APIResponse.new(response.body)
    end

    def fetch_cover(response)
      res = response.to_h
      response_url = res['RESPONSE']['ALBUM']['URL']
      title = res['RESPONSE']['ALBUM']['TITLE']
      APIRequest.get_file(response_url, "#{title}-cover.jpeg")
    end

#    private

    def get_toc
      TOCReader.read
    end
  end
end