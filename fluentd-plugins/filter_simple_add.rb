require 'fluent/plugin/filter'

module Fluent
  module Plugin
    class SimpleAddFilter < Filter
      Fluent::Plugin.register_filter('simple_add', self)

      # Define a configurable parameter called "custom_value"
      # :string means it’s a text value, default is "valueFromFilter" if not specified
      config_param :custom_value, :string, default: "valueFromFilter"

      # This method runs once when Fluentd starts, setting up the plugin
      def configure(conf)
        super  # Call the parent’s configure method (important for Fluentd internals)
        # @custom_value is now available as an instance variable
      end

      def filter(tag, time, record)
        # Use the user-defined value (or default) instead of hardcoding
        record["variabFromFilter"] = @custom_value
        record  # Return the modified record
      end
    end
  end
end

#Usage
#<filter myapp.log>
#  @type simple_add
#  custom_value "MyCustomString"
#</filter>