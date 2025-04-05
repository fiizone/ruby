# test_plugin.rb
require_relative 'filter_simple_add'
require 'fluent/plugin/filter'
require 'fluent/config'
require 'ostruct'

# Fake Fluentd’s logger
class TestLogger
  def info(msg); puts "[INFO] #{msg}"; end
  def warn(msg); puts "[WARN] #{msg}"; end
  def error(msg); puts "[ERROR] #{msg}"; end
end

# Stub Fluent::Engine to avoid initialization conflicts
module Fluent
  module Engine
    def self.root_agent
      OpenStruct.new(event_router: nil)
    end
  end
end

# Stub Fluent::Plugin::Filter to bypass full Fluentd setup
module Fluent
  module Plugin
    class Filter
      # Stub inherited methods that might call Engine
      def context_router; nil; end
      attr_accessor :log  # Allow logger to be set
    end
  end
end

# Create a test harness
class PluginTester
  def initialize
    # Simulate Fluentd’s config
    config = Fluent::Config::Element.new('filter', '', {
      'error_codes_file' => './error_codes.json'
    }, [])

    # Instantiate your plugin
    @plugin = Fluent::Plugin::SimpleAddFilter.new
    @plugin.log = TestLogger.new  # Assign fake logger

    # Call configure with our fake config
    @plugin.configure(config)
  end

  def test_filter
    record = {
      "ts" => 1738557840904.059,
      "logger" => "UnhandledError",
      "msg" => "Unhandled Error",
      "error_code" => "ERR001"
    }
    tag = "kubernetes.logs"
    time = Time.now

    puts "Original record: #{record.inspect}"
    modified_record = @plugin.filter(tag, time, record)
    puts "Modified record: #{modified_record.inspect}"
  end

  def test_unknown_code
    record = {
      "ts" => 1738557840905.000,
      "msg" => "Unknown error",
      "error_code" => "ERR999"
    }
    tag = "kubernetes.logs"
    time = Time.now

    puts "\nOriginal record (unknown code): #{record.inspect}"
    modified_record = @plugin.filter(tag, time, record)
    puts "Modified record (unknown code): #{modified_record.inspect}"
  end
end

# Run the tests
tester = PluginTester.new
tester.test_filter
tester.test_unknown_code