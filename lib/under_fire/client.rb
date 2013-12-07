require 'under_fire/album_search'
require 'under_fire/album_toc_search'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/configuration'
require 'under_fire/toc_reader'

require 'pry'

module UnderFire
  # Public interface to UnderFire's functionality.
  #
  # @example
  #   client = UnderFire::Client.new
  #   client.album_search(:artist => 'Miles Davis') #=> lots of results
  #   
  #   client = UnderFire::Client.new
  #   client.find_by_toc
  class Client
    include UnderFire

    # @return [String] API URL for application.
    attr_reader :api_url

    def initialize
      @api_url = Configuration.api_url
    end

    # Searches for album using TOC of CD in drive.
    # @return [APIResponse] 
    # @see UnderFire::AlbumTOCSearch
    def find_by_toc
      search = AlbumTOCSearch.new(get_toc)
      response = APIRequest.post(search.query, api_url)
      APIResponse.new(response.body)
    end
    
    # Finds album using one or more of :artist, :track_title and :album_title
    # @return [APIResponse]
    # @see UnderFire::AlbumSearch Description of arguments.
    def find_album(args)
      search = AlbumSearch.new(args)
      response = APIRequest.post(search.query, api_url)
      APIResponse.new(response.body)
    end

    # Fetches cover art using results of query.
    # @param [APIResponse]
    def fetch_cover(response)
      res = response.to_h
      response_url = res['RESPONSE']['ALBUM']['URL']
      title = res['RESPONSE']['ALBUM']['TITLE']
      APIRequest.get_file(response_url, "#{title}-cover.jpeg")
    end

    private

    def get_toc
      TOCReader.read
    end
  end
end
