require 'under_fire/configuration'
require 'builder'

module UnderFire
  # Builds an XML query with information common to all queries (to be subclassed by individual queries).
  class BaseQuery
    # @return [String]
    attr_reader :mode

    # @return [UnderFire::Configuration]
    attr_reader :config

    # @param [String] mode Either 'SINGLE_BEST' or 'SINGLE_BEST_COVER' (defaults to 'SINGLE_BEST_COVER').
    def initialize(mode="SINGLE_BEST_COVER")
      @mode = mode || "SINGLE_BEST_COVER"
      @config = Configuration.instance
    end

    # @yield [Builder] builder object used by subclass's build_query method.
    def build_base_query(&block)
      builder = Builder::XmlMarkup.new
      builder.queries {
        builder.AUTH {
          builder.CLIENT config.client_id
          builder.USER config.user_id
        }
        builder.lang "eng"
        builder.country "canada"
        builder.app_info %Q{app="under-fire #{VERSION}", os="#{RUBY_PLATFORM}"}
        yield builder
      }
    end
  end
end
