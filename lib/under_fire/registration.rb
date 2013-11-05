require 'under_fire/configuration'
require 'builder'

module UnderFire
  class AlbumSearch
    attr_reader :query

    def initialize
      @query = build_query
    end

    def build_query
      builder = Builder::XmlMarkup.new
      xml = builder.queries {
        builder.query(cmd: 'REGISTER'){
        builder.client UnderFire::Configuration.client_id
        }
      xml
    end
  end
end
