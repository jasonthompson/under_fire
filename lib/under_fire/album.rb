module UnderFire
  class Album
      # <GN_ID>86372321-2C7F28ADC369EB90E53A7F6CA3A70D56</GN_ID>
      # <ARTIST>The Beatles</ARTIST>
      # <TITLE>Help!</TITLE>
      # <PKG_LANG>ENG</PKG_LANG>
      # <GENRE NUM="61364" ID="25332">60&apos;s Rock</GENRE>
      # <TRACK_COUNT>13</TRACK_COUNT>
      # <TRACK>
      #   <TRACK_NUM>1</TRACK_NUM>
      #   <GN_ID>86372322-05CF584F3265FA67F3E0C18987973C21</GN_ID>
      #   <TITLE>Help!</TITLE>
      # </TRACK>

    attr_accessor :title
    attr_accessor :artist
    attr_accessor :gn_id
    attr_accessor :genre
    attr_accessor :track_count
    attr_accessor :track
    attr_accessor :pkg_lang
    attr_accessor :date

    alias_method :tracks, :track
    alias_method :tracks=, :track=

    def initialize(args={})
      args.each {|k,v| send("#{k}=", v)}
    end
  end
end
