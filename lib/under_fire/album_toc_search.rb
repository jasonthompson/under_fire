require 'under_fire/base_query'
require 'builder'

module UnderFire
  class AlbumTOCSearch < BaseQuery
    attr_accessor :toc, :query

    def initialize(toc)
      @toc = toc
      @query = build_query
    end

    def build_query
      builder = build_base_query
      builder.queries {
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
    end
  end
end
