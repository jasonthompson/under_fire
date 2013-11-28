require 'under_fire/configuration'
require 'builder'

module UnderFire
  class BaseQuery
    def build_base_query(&block)
      builder = Builder::XmlMarkup.new
      builder.queries {
        builder.auth {
          builder.client Configuration.client_id
          builder.user Configuration.user_id
        }
        builder.lang "eng"
        builder.country "canada"
        builder.app_info %Q{app="under-fire #{VERSION}", os="#{RUBY_PLATFORM}"}
        yield builder
      }
    end
  end
end
