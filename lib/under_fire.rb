require 'under_fire/version'
require 'under_fire/configuration'
require 'under_fire/album_search'
require 'under_fire/registration'
require 'under_fire/api_request'
require 'under_fire/api_response'
require 'under_fire/album_toc_search'

module UnderFire
  def album_search(params)
    as = AlbumSearch.new(params)
    req = ApiRequest.post(as.query)
    res = ApiResponse.new(req.body)
  end

  def album_toc_search
    as = AlbumTocSearch.new(get_toc)
    res = ApiRequest.post(as.query)
    ApiResponse.new(res.body)
  end

  def get_toc(discid=`discid`)
    discid.split[2..-2].join " "
  end

  module_function :album_search, :album_toc_search, :get_toc
end
