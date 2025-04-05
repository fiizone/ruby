# filter_simple_add.rb
require 'fluent/plugin/filter'
require 'json'

module Fluent
  module Plugin
    class SimpleAddFilter < Filter
      Fluent::Plugin.register_filter('simple_add', self)

      config_param :error_codes_file, :string, default: nil

      def configure(conf)
        super
        if @error_codes_file
          begin
            @error_mappings = JSON.parse(File.read(@error_codes_file))
            log.info "Loaded error mappings: #{@error_mappings.inspect}"
          rescue Errno::ENOENT, JSON::ParserError => e
            log.error "Failed to load error codes from #{@error_codes_file}: #{e.message}"
            @error_mappings = {}
          end
        else
          @error_mappings = {}
          log.warn "No error_codes_file specified, using empty mappings"
        end
      end

      def filter(tag, time, record)
        log.info "Processing record: #{record.inspect}"
        if record["error_code"]
          description = @error_mappings[record["error_code"]] || nil
          log.info "Found error_code '#{record["error_code"]}', description: #{description.inspect}"
          record["error_description"] = description
        else
          log.info "No error_code found in record"
        end
        record
      end
    end
  end
end