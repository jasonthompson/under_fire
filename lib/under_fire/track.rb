module UnderFire
  class Track
    # @return [String] Track title
    attr_reader :title

    # @return [String] Gracenote ID
    attr_reader :gn_id

    # @return [Integer] Track number on album
    attr_reader :track_number

    def initialize(track_info)
      @title = track_info[:title]
      @gn_id = track_info[:gn_id]
      @track_number = track_info[:track_num].to_i
    end
  end
end
