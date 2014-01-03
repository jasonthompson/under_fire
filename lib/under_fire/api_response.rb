require 'nori'

module UnderFire
  # Wraps query response.
  class APIResponse
    # @return [Hash] Response as Hash.
    attr_reader :response

    # @param [String] response XML string.
    def initialize(response)
      @response = parse_response(response)
    end

    # @return [Hash] Hash representation of response.
    def to_h
      response[:responses]
    end

    # @return [String] String represenation suitable for command line.
    def to_s
      recursive_to_s(to_h)
    end

    # @return [Boolean] Did the query return something?
    def success?
      to_h[:response][:@status] == 'OK'
    end

    # @return [Boolean] Are there any album listings in response?
    def albums?
      to_h[:response].has_key?(:album)
    end

    # @return [Integer] Number of album listings in response.
    def album_count
      count = 0
      count = to_h[:response][:album].count if albums?
      count
    end

    def albums
     [] 
    end

    private

    # Recursively walks nested hash structure to return string representation.
    # @return [String] Flat string representation of nest Hash.
    def recursive_to_s(hash)
      output = ""
      hash.each do |k,v|
        if v.is_a? Hash
          output << "\n"
          output << "#{k}:\n#{recursive_to_s(v)}\n"
        elsif v.is_a? Array
          output << "\n"
          v.each {|i| output << "#{recursive_to_s(i)}\n" }
        else
          output << "#{k}: #{v}\n"
        end
      end
      output
    end

    # Builds hash from XML response.
    # @param [String] response XML response string.
    # @return [Hash] Hash representation of response.
    def parse_response(response)
      parser = Nori.new(:convert_tags_to => lambda {|tag| tag.snakecase.to_sym})
      parser.parse(response)
    end
  end
end
