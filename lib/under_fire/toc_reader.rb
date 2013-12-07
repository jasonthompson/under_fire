require 'discid'

module UnderFire
  # Reads CD and returns table of contents (start frame of each track).
  # 
  # @example
  #   UnderFire.TOCReader.read
  class TOCReader
    # @return [Array<String>] array of start frame strings
    def self.read
      device = "/dev/cdrom"
      disc = DiscId.read(device)
      toc = []
      disc.tracks {|t| toc << t.offset.to_s}
      toc.join(" ")
    end
  end
end

