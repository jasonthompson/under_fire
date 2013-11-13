require 'nori'

module UnderFire
  class ApiResponse
    
    def initialize(response)
      @response = parse_response(response)
    end

    def to_h
      @response['RESPONSES']['RESPONSE']
    end

    private

    def parse_response(response)
      parser = Nori.new
      parser.parse(response)
      if response[:RESPONSES]["STATUS"] == "ERROR"
        puts response[:RESPONSES]["Message"]
      end
    end
  end
end
