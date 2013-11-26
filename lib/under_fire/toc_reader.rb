require 'discid'

module UnderFire
  class TOCReader
    def self.read
      device = "/dev/cdrom"
      disc = DiscId.read(device)
      toc = []
      disc.tracks {|t| toc << t.offset.to_s}
      toc.join(" ")
    end
  end
end

