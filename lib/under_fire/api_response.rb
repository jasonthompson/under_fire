require 'nori'

module UnderFire
  class ApiResponse
    attr_reader :response

    def initialize(response)
      @response = parse_response(response)
    end

    def to_h
      response['RESPONSES']
    end

    ##
    # String output for command line use.
    # Haven't decided how to format output.
    def to_s
      recursive_each(to_h)
    end

    private

    def recursive_each(hash)
      hash.each do |k,v|
        if v.is_a? Hash
          puts "#{k}: "
          recursive_each(v)
        elsif v.is_a? Array
          v.each {|i| recursive_each(i)}
        else
          puts "#{k}: #{v}"
        end
      end
    end

    def parse_response(response)
      parser = Nori.new
      parser.parse(response)
    end
  end
 end
