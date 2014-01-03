module UnderFire
  class Album
    # @return [String] Album title.
    attr_accessor :title

    # @return [String] Name of artist.
    attr_accessor :artist

    # @return [String] Gracenote ID for album.
    attr_accessor :gn_id

    # @return [String]
    attr_accessor :genre

    # @return [Int]
    attr_accessor :track_count

    # @return [String] Language used.
    attr_accessor :pkg_lang

    attr_writer :date
    attr_writer :track
    
    def initialize(args={})
      args.each {|k,v| send("#{k}=", v)}
    end
  
    # @return [Date] Album year.
    def date
      Date.new(@date.to_i)
    end

    # @return [Array<Track>] An array of Tracks on album
    def tracks
      require 'under_fire/track'
      @track.map {|t| UnderFire::Track.new(t)}
    end
  end
end
