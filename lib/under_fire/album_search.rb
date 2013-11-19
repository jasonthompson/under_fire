require 'under_fire/configuration'
require 'builder'

module UnderFire
  class AlbumSearch
    attr_accessor :artist, :track_title, :album_title, :query, :parameters, 
      :mode

    def initialize(args={})
      @parameters = args.reject {|k,v| k == :mode}
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
          builder.mode mode
          parameters.each do |k,v|
            builder.text(v, type: k.to_s.upcase)
          end
          }
        }
      xml
    end
  end
end
