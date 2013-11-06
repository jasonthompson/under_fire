require 'ansi/code'

module Minitest
  def self.plugin_doc_reporter_options(opts, options)
  end

  def self.plugin_doc_reporter_init(options)
    self.reporter << DocReporter.new(options)
  end

  def self.run args = []
    self.load_plugins

    options = process_args args

    reporter = CompositeReporter.new


    self.reporter = reporter # this makes it available to plugins
    self.init_plugins options
    self.reporter = nil # runnables shouldn't depend on the reporter, ever

    reporter.start
    __run reporter, options
    reporter.report

    reporter.passed?
  end

  class DocReporter < AbstractReporter
    include ANSI::Code

    attr_reader :io, :options, :results, :errors

    attr_accessor :start_time, :total_time, :failures, :errors, :skips, :count

    def initialize(io = $stdout, options = {})
      @io = io
      @options = options
      @results = []
      self.count = 0
    end

    def start
      
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
      self.count = self.count + 1
      results << result if not result.passed? or result.skipped?
    end

    def report
      super

      aggregate = results.group_by { |r| r.failure.class }
      aggregate.default = [] # dumb. group_by should provide this

      total_time = Time.now - start_time
      failures   = aggregate[Assertion].size
      errors     = aggregate[UnexpectedError].size
      skips      = aggregate[Skip].size

      puts
      puts "#{error_summary(errors)} #{failure_summary(failures)}"
    end

    private
    
    def error_summary(count)
      summary = ANSI.bold + "Errors: #{count}"
      if count.zero?
        return ANSI.white + summary
      else
        return ANSI.red + summary
      end
    end

    def failure_summary(count)
      summary = "Failures: #{count}"
      if count.zero?
        return ANSI.white + summary
      else
        return ANSI.red + summary
      end
    end
  end
end
