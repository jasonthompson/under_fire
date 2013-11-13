require 'under_fire/configuration'
require 'builder'

module UnderFire
  class AlbumTocSearch
    attr_accessor :toc, :query

    def initialize(toc)
      @toc = toc
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
        builder.query(cmd: "ALBUM_TOC"){
          builder.mode "SINGLE_BEST_COVER"
          builder.toc {
            builder.offsets toc
          }
        }
      }
      xml
    end
  end
end
