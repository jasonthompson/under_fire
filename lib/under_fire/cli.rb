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
    def toc
      as = AlbumTocSearch.new(get_toc)
      res = ApiRequest.post(as.query, Configuration.api_url)
      say ApiResponse.new(res.body).to_s
    end

    desc "album", "Queries Gracenote with album <title>, <song> title, or <artist> name"
    method_option :album_title, :aliases => '-t', :desc => "Specify album title",  :required => false
    method_option :song_title, :aliases => '-s', :desc => "Specify song title", :required => false
    method_option :artist, :aliases => '-a', :desc => "Specify artist name", :required => false
    def album
      search = AlbumSearch.new(options)
      request = ApiRequest.post(search.query, Configuration.api_url)
      say ApiResponse.new(request.body).to_s
    end

    desc "cover", "Gets cover from Gracenote."
    method_option :url, :aliases => '-u', :required => true,
      :desc => "URL provided by Gracenote for downloading cover image."
    method_option :file_name, :aliases => '-f', :required => false,
      :desc => "File name for saving image."
    def cover
      say "Fetching cover"
      url = options[:url]
      file_name = options[:file_name].empty? ? "cover.jpg" : options[:file_name]
      ApiRequest.get_file(url, file_name)
      say "saved #{file_name} in #{File.dirname __FILE__}"
    end
  end
end
