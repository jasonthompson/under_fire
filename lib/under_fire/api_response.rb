require 'nori'

module UnderFire
  class APIResponse
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
      recursive_to_s(to_h)
    end

    def success?
      response['RESPONSES']['RESPONSE']['@STATUS'] == 'OK'
    end

    private 

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
    def parse_response(response)
      parser = Nori.new
      parser.parse(response)
    end
  end
 end
