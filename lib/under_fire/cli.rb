require 'thor'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/album_toc_search'
require 'under_fire/album_search'

module UnderFire
  class CLI < Thor
    include UnderFire

    def initialize(*)
      super
    end

    desc  "toc", "Uses `discid` to get a CD's table of contents and then " +
      "uses the TOC to query Gracenote for album information."
    def toc()
      as = AlbumTocSearch.new(get_toc)
      res = ApiRequest.post(as.query)
      say ApiResponse.new(res.body).to_s
    end
    
    desc "album", "Queries Gracenote with album <title>, <song> title, or <artist> name"
    method_option :album_title, :aliases => '-t', :desc => "Specify album title",  :required => false
    method_option :song_title, :aliases => '-s', :desc => "Specify song title", :required => false
    method_option :artist, :aliases => '-a', :desc => "Specify artist name", :required => false
    def album()
      search = AlbumSearch.new(options)
      request = ApiRequest.post(search.query)
      say ApiResponse.new(request.body).to_s
    end
  end
end
