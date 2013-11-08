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

    attr_reader :io, :options, :results

    attr_accessor :start_time, :total_time, :failures, :errors, :skips, :count, 
      :results

    def initialize(io = $stdout, options = {})
      @io = io
      @options = options
      self.results = []
      self.errors = 0
      self.skips = 0
      self.count = 0
      self.failures = 0
    end

    def start
      self.start_time = Time.now
    end

    def record(result)
      puts format_header(result.class)
      puts format_result(result)
      puts

      if result.error?
        puts format_error_info(result)
        puts
      end

      if result.failure
        puts pad(result.failure.to_s)
        puts
      end

      self.count += 1

      self.results << result if not result.passed? or result.skipped?
    end

    def report
      super

      aggregate = self.results.group_by { |r| r.failure.class }
      aggregate.default = [] # dumb. group_by should provide this

      self.failures   = aggregate[Assertion].size
      self.errors     = aggregate[UnexpectedError].size
      self.skips      = aggregate[Skip].size

      puts
      puts format_tests_run_count(count, total_time)
      puts statistics
      puts
    end

    private

    def statistics
      "#{format_result_type('Errors', errors, :red)} #{format_divider}" + \
      "#{format_result_type('Failures', failures, :red)} #{format_divider}" + \
      "#{format_result_type('Skips', skips, :yellow)}"
    end

    def total_time
      Time.now - start_time
    end

    #formatters
    def pad(str, amount = 2)
      " " * amount + str
    end

    def format_error_info(result)
      e = result.failure.exception
      bt = Minitest.filter_backtrace e.backtrace
      pad(ANSI.bold {e.class.to_s} + "\n" + pad(e.message.to_s) + "\n" + \
          format_backtrace(bt))
    end

    def format_backtrace(bt)
      output = ""
      bt.each {|l| output << l}
      pad output
    end

    def format_result(result)
      output = ""
      if result.passed? 
        output =  ANSI.green {result.name}
      else
        output = ANSI.red {result.name}
      end
      pad output
    end

    def format_header(header)
      ANSI.bold(header)
    end

    def format_tests_run_count(count, total_time)
      ANSI.bold "#{count} tests run in #{total_time}"
    end

    def format_result_type(type, count, colour)
      summary = "#{type}: #{count}"

      if count.zero?
        return ANSI.ansi(summary, :white, :bold)
      else
        return ANSI.ansi(summary, colour, :bold)
      end
    end

    def format_divider(divider = '|')
      ANSI.white + ANSI.bold + " #{divider} "
    end
  end
end
