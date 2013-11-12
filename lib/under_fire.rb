require 'under_fire/version'
require 'under_fire/configuration'
require 'under_fire/album_search'
require 'under_fire/registration'
require 'under_fire/api_response'
require 'under_fire/album_toc_search'

module UnderFire
  def get_album_toc
    `discid`.split[2..-2].join " "
  end

  module_function :get_album_toc
end
