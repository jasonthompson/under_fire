require 'under_fire/album_search'
require 'under_fire/album_toc_search'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/configuration'

module UnderFire
  class Client
    include UnderFire

    attr_reader :api_url

    def initialize
      @user_id = Configuration.user_id
      @client_id = Configuration.client_id
      @api_url = Configuration.api_url
    end

    def toc_search
      search = AlbumTocSearch.new(get_toc)
      response = ApiRequest.post(search.query, api_url)
      ApiResponse.new(response.body)
    end

    def album_search(args)
      search = AlbumSearch.new(args)
      response = ApiRequest.post(search.query, api_url)
      ApiResponse.new(response.body)
    end

    private

    def get_toc(discid=`discid`)
      discid.split[2..-2].join " "
    end
  end
end
