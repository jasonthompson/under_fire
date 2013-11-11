require 'nori'

module UnderFire
  class ApiResponse
    attr_reader :response

    def initialize(response)
      @response = parse_response(response)
    end

    private

    def parse_response(response)
      parser = Nori.new
      parser.parse(response)
    end
  end
end
