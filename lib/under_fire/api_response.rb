require 'nori'

module UnderFire
  class ApiResponse
    def initialize(response)
      @response = parse_response(response)
    end

    def to_h
      @response
    end

    private

    def parse_response(response)
      parser = Nori.new
      parser.parse(response)
    end
  end
end
