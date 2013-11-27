require 'under_fire/base_query'
require 'builder'

module UnderFire
  class AlbumSearch < BaseQuery
    attr_accessor :artist, :track_title, :album_title, :query, :parameters

    def initialize(args={})
      @parameters = args
      args.each do |k,v| send("#{k}=", v) end
      @query = build_query
    end

    def build_query
      builder = build_base_query
      xml = builder.query(cmd: "ALBUM_SEARCH"){
        builder.mode "SINGLE_BEST_COVER"
        parameters.each do |k,v|
          builder.text(v, type: k.to_s.upcase)
        end
      }
      xml
    end
  end
end
