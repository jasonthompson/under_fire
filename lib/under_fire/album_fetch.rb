module UnderFire
  class AlbumFetch < BaseQuery
    # @return [String] XML string for query.
    attr_reader :query

    # @return [Hash] Search parameters with :mode removed.
    attr_reader :parameters

    # @return [String] Gracenote ID for album
    attr_accessor :gn_id
    
    def initialize(args)
      super args
      @parameters = args.reject {|k,v| k == :mode}
      parameters.each do |k,v| send("#{k}=", v) end
      @query = build_query 
    end
    
    def build_query
      build_base_query do |builder|
        builder.query(cmd: "ALBUM_FETCH"){
          builder.mode "SINGLE_BEST_COVER"
          parameters.each do |k,v|
            builder.gn_id gn_id
          end
        }
      end
    end
  end
end
