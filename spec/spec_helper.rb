require 'minitest/autorun'
require 'minitest-doc-reporter'
require File.expand_path('../../lib/under_fire.rb', __FILE__)

Minitest.reporter = Minitest::DocReporter
