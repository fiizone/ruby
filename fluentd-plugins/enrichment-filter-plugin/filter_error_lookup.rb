# Load Fluentd's filter plugin tools and JSON library
require 'fluent/plugin/filter'
require 'json'

# Organize our code in Fluent's plugin namespace
module Fluent
  module Plugin
    # Define our plugin class, inheriting from Filter
    class ErrorLookupFilter < Filter
      # Register the plugin with Fluentd as 'error_lookup'
      Fluent::Plugin.register_filter('error_lookup', self)

      # Define a config parameter for the error codes file path
      config_param :error_codes_file, :string, default: '/etc/fluent/fluent.d/error_codes.json'

      # Called when Fluentd starts up the plugin
      def configure(conf)
        super
        # Load the error codes into a hash, or use empty hash if it fails
        @error_mappings = load_error_codes
      end

      # Method to load the JSON file
      def load_error_codes
        if File.exist?(@error_codes_file)
          begin
            JSON.parse(File.read(@error_codes_file))
          rescue => e
            # Log the error and return an empty hash
            log.error "Failed to load error codes from #{@error_codes_file}: #{e.message}"
            {}
          end
        else
          log.warn "Error codes file not found: #{@error_codes_file}"
          {}
        end
      end

      # The main method where we process each log record
      def filter(tag, time, record)
        # Work on a copy of the record to avoid issues
        new_record = record.dup

        # Look for error_code directly or extract from log
        err_code = new_record["error_code"]
        if !err_code && new_record["log"].is_a?(String)
          match = new_record["log"].match(/(ERR\d{3})/)
          err_code = match[1] if match
        end

        # If we found an error code, add the message
        if err_code
          new_record["error_code"] = err_code
          error_description = @error_mappings[err_code]
          new_record["error_code_message"] = error_description.nil? ? nil : error_description
        end

        # Return the modified record
        new_record
      end
    end
  end
end
