require 'ansi/code'

module Minitest
  def self.plugin_doc_reporter_options(opts, options)
  end

  def self.plugin_doc_reporter_init(options)
    self.reporter << DocReporter.new(options)
  end

  class DocReporter < StatisticsReporter
    include ANSI::Code

    attr_reader :io, :options

    def initialize(io = $stdout, options = {})
      super
    end

    def start
      super

      self.start_time = Time.now
    end

    def record(result)
      puts " #{result.class}"
      if result.passed? 
        puts ANSI.green {" #{result.name}"}
      else
        puts ANSI.red {" #{result.name}"}
      end
      puts ""

      results << result if not result.passed? or result.skipped?
    end

    def report
      super

      aggregate = results.group_by { |r| r.failure.class }
      aggregate.default = [] # dumb. group_by should provide this

      self.total_time = Time.now - start_time
      self.failures   = aggregate[Assertion].size
      self.errors     = aggregate[UnexpectedError].size
      self.skips      = aggregate[Skip].size
    end
  end
end
