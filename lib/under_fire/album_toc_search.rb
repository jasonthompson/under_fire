require 'under_fire/configuration'
require 'builder'

module UnderFire
  class AlbumTOCSearch
    attr_accessor :toc

    def initialize(toc)
      @toc = toc
    end

    def query
      build_query
    end

    def build_query
      builder = Builder::XmlMarkup.new
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
