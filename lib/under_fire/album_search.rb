require 'under_fire/configuration'
require 'builder'

module UnderFire
  class AlbumSearch
    attr_accessor :artist, :track_title, :album_title, :album_toc, :query

    def initialize(args={})
      args.each do |k,v| send("#{k}=", v) end
      @query = build_query
    end

    def build_query
      builder = Builder::XmlMarkup.new
      xml = builder.queries {
        builder.auth {
          builder.client UnderFire::Configuration.client_id
          builder.user UnderFire::Configuration.user_id
          }
        builder.lang "eng"
        builder.country "canada"
        builder.query(cmd: "ALBUM_SEARCH"){
          builder.text(album_title, type: "ALBUM_TITLE")
          builder.text(track_title, type: "TRACK_TITLE")
          builder.text(artist, type: "ARTIST")
          }
        }
      xml
    end
  end
end
