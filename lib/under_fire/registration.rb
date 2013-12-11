require 'under_fire/configuration'
require 'builder'

module UnderFire
  # Register an application using client_id (only needs to be done once per application).
  #
  # @see https://developer.gracenote.com/sites/default/files/web/html/index.html#Music%20Web%20API/Registration%20and%20Authentication.html#_Toc344907213
  class Registration
    # @return [String] XML string for query 
    attr_reader :query
    
    def initialize
      @query = build_query
    end
    
    # Builds XML for REGISTRATION query.
    #
    # @return [String] XML string for REGISTRATION
    def build_query
      builder = Builder::XmlMarkup.new
      xml = builder.queries {
        builder.query(cmd: 'REGISTER'){
        builder.client UnderFire::Configuration.client_id
        }
      }
      xml
    end
  end
end
