require 'under_fire/base_query'
require 'builder'

module UnderFire
  class AlbumTOCSearch < BaseQuery
    attr_accessor :toc, :query

    def initialize(args)
      super args[:mode]
      @toc = args[:toc]
      @query = build_query
    end

    def build_query
      build_base_query do |builder|
        builder.query(cmd: "ALBUM_TOC"){
          builder.mode mode
          builder.toc {
            builder.offsets toc
          }
        }
      end
    end
  end
end
