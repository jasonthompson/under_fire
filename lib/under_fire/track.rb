module UnderFire
  class Track
    # @return [String] Track title
    attr_reader :title

    # @return [String] Gracenote ID
    attr_reader :gn_id

    def initialize(track_info)
      @title = track_info[:title]
      @gn_id = track_info[:gn_id]
    end
  end
end
