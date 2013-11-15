require 'under_fire/version'
require 'under_fire/configuration'
require 'under_fire/album_search'
require 'under_fire/registration'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/album_toc_search'

module UnderFire
  def get_album_toc
    parse_discid_output
  end

  def album_search(params)
    as = AlbumSearch.new(params)
    req = ApiRequest.post(as.query)
    res = ApiResponse.new(req.body)
    puts res.to_h
  end

  def album_toc_search(toc)
    as = AlbumTocSearch.new(toc)
    req = ApiRequest.post(as.query)
    res = ApiResponse.new(req.body)
    puts res.to_h
  end
  
  def parse_discid_output(discid=`discid`)
    output = discid.split[2..-2].join " "
    puts output
  end

  module_function :get_album_toc, :album_search, :album_toc_search, :parse_discid_output
end
