require 'ansi/code'

module Minitest
  def self.plugin_doc_reporter_options(opts, options)
  end
  
  def self.plugin_doc_reporter_init(options)
    self.reporter << DocReporter.new(options)
  end
  
  class DocReporter < AbstractReporter
    include ANSI::Code
    
    attr_reader :io, :options

    def initialize(io = IO)
      @io = io
    end

    def start
      puts ANSI.bold {"##Documentation Reporter##"}
      puts ""
    end

    def record(test)
      puts " #{test.class}"
      puts " #{test.name}"
      puts ""
    end
  end
end
