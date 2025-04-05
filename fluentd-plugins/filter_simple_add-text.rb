# This line tells Ruby to load Fluentd's filter plugin tools
require 'fluent/plugin/filter'

# "module" is like a big folder to organize our code
module Fluent
  # "module Plugin" is a subfolder inside Fluent
  module Plugin
    # "class" is where we define our plugin, inheriting from Fluentd's Filter tool
    class SimpleAddFilter < Filter
      # This registers our plugin with Fluentd, so Fluentd knows it exists
      # 'simple_add' is the name we'll use in the config file
      Fluent::Plugin.register_filter('simple_add', self)

      # This is the main method where we change the log
      def filter(tag, time, record)
        # Add our key/value pair to the log (record is like a Ruby dictionary)
        record["variabFromFilter"] = "valueFromFilter"
        # Return the changed log so Fluentd can pass it along
        record
      end
    end
  end
end

##Usage:
#<filter myapp.log>     # Apply our filter to logs tagged "myapp.log"
#  @type simple_add     # The name we registered in the .rb file
#</filter>