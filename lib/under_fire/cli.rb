require 'thor'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/album_toc_search'
require 'under_fire/album_search'

module UnderFire
  # Command Line interface
  class CLI < Thor
    include UnderFire

    def initialize(*)
      super
    end

    desc  "toc", "Uses provided TOC to query Gracenote for album information."
    def toc(*offsets)
      offsets = offsets.join(" ")
      search = AlbumTOCSearch.new(:toc => offsets)
      response = APIRequest.post(search.query, Configuration.api_url)
      say APIResponse.new(response.body).to_s
    end

    desc "album", "Queries Gracenote with album <title>, <song> title, or <artist> name"
    method_option :album_title,
      :aliases => '-t',
      :desc => "Specify album title",
      :required => false
    method_option :track_title,
      :aliases => ['-s', :song_title],
      :desc => "Specify song title",
      :required => false
    method_option :artist,
      :aliases => '-a',
      :desc => "Specify artist name",
      :required => false
    def album
      search = AlbumSearch.new(options)
      request = APIRequest.post(search.query, Configuration.api_url)
      say APIResponse.new(request.body).to_s
    end

    desc "id", "Fetches album info using given Gracenote ID."
    method_option :gn_id, :aliases => ['-i', '--id'], :required => true,
      :desc => "Gracenote album or song GN_ID"
    def id
      search = AlbumFetch.new(options)
      request = APIRequest.post(search.query, Configuration.api_url)
      say APIResponse.new(request.body).to_s
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
      APIRequest.get_file(url, file_name)
      say "saved #{file_name} in #{File.dirname __FILE__}"
    end
  end
end
