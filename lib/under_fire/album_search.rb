require 'under_fire/base_query'
require 'builder'

module UnderFire
  # Builds XML for Gracenote's ALBUM_SEARCH query
  # @see https://developer.gracenote.com/sites/default/files/web/html/index.html#Music%20Web%20API/ALBUM_SEARCH.html#_Toc344907249
  #
  class AlbumSearch < BaseQuery
    attr_reader :artist, :track_title, :album_title, :query, :parameters

    # @param args [{Symbol => String}]
    #
    def initialize(args={})
      super args[:mode]
      @parameters = args.reject {|k,v| k == :mode}
      parameters.each do |k,v| send("#{k}=", v) end
      @query = build_query
    end

    def build_query
      build_base_query do |builder|
        builder.query(cmd: "ALBUM_SEARCH"){
          builder.mode "SINGLE_BEST_COVER"
          parameters.each do |k,v|
            builder.text(v, type: k.to_s.upcase)
          end
        }
      end
    end
  end
end
