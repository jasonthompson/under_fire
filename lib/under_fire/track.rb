module UnderFire
  class Track
    attr_accessor :title
    attr_accessor :track_num
    attr_accessor :gn_id

    def initialize(args={})
      args.each {|k,v| send("#{k}=", v)}
    end
  end
end
