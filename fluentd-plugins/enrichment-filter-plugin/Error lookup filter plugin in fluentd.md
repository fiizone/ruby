# Error lookup filter plugin in fluentd

in this plugin I demonstrated an enrichment of logs in fluentd with a filter plugin, I wanted to use `exec_filter` towards that but somehow it didn't work out right as described below, so I tended to develope a filter plugin that does the same thing but more efficiently than the `exec_filter` way. you do the math which one is better :D

and just sharing the `exec_filter` way, just in case anyone could improve it :D

## Enrichment of logs with exec_filter output

- we have a sample log like below:
  
  - ```json
    {"log":"Error occurred: ERR001","error_code":"ERR001"}
    ```

- we have a mapping of error codes in a local file that we want to use it as below:
  
  - in this file: `/etc/fluent/fluent.d/error_codes.json`
    
    ```json
    {"ERR001": "Database connection failed","ERR002": "Invalid user input","ERR003": "Timeout while processing request"}
    ```

- then we have our ruby code like this:
  
  - file at here: `/etc/fluent/fluent.d/error_lookup_json.rb`
    
    ```ruby
    #!/usr/bin/env ruby
    require 'json'
    
    ERROR_CODES_FILE = "/etc/fluent/fluent.d/error_codes.json"
    
    def load_error_codes
      begin
        file_content = File.read(ERROR_CODES_FILE)
        JSON.parse(file_content)
      rescue StandardError => e
        STDERR.puts "Error loading error codes: #{e.message}"
        {}
      end
    end
    
    ERROR_CODES = load_error_codes
    
    # Ensure non-blocking I/O
    STDIN.sync = true
    STDOUT.sync = true
    
    begin
      while line = STDIN.gets # Continuously read from STDIN
        line.chomp!
        begin
          record = JSON.parse(line) # Parse JSON input from Fluentd
          output = {}
    
          # Copy log field if present
          output["log"] = record["log"] if record["log"]
    
          # Process error_code or extract from log
          if record["error_code"]
            err_code = record["error_code"]
            output["error_code"] = err_code
            output["error_code_message"] = ERROR_CODES[err_code] || "Unknown error"
          elsif record["log"] && (match = record["log"].match(/(ERR\d{3})/))
            err_code = match[1]
            output["error_code"] = err_code
            output["error_code_message"] = ERROR_CODES[err_code] || "Unknown error"
          end
    
          # Output as JSON with a newline
          STDOUT.puts output.to_json unless output.empty?
    
        rescue JSON::ParserError => e
          STDERR.puts "JSON parse error: #{e.message}, input: #{line}"
        end
      end
    rescue Interrupt # Graceful shutdown on SIGTERM
      exit 0
    rescue EOFError # Handle STDIN close
      exit 0
    end
    ```

- then we can invoke the code like this to verify it works:
  
  - ```bash
    echo '{"log":"Error occurred: ERR001","error_code":"ERR001"}' | sudo -u _fluentd /usr/bin/ruby /etc/fluent/fluent.d/error_lookup_json.rb
    ```

- to use this in fluentd I deployed this kind of config:
  
  - ```yaml
    <match test.logs>
      @type exec_filter
      command "/usr/bin/ruby /etc/fluent/fluent.d/error_lookup_json.rb"
      tag enriched.promtest.logs
      <format>
        @type json
      </format>
      <parse>
        @type json
      </parse>
      <buffer>
        flush_interval 10s
      </buffer>
    </match>
    
    <filter enriched.test.logs>
      @type stdout
    </filter>
    ```
  
  - it didn't work by any means, so we go for next solution

## developing our own filter plugin towards enrichment of logs

- we start by having sample log which is a kubernetes log which is in json with cri tags with it (actually I added to demonstrate how to deal with those kind of stuff):
  
  - ```json
    2025-02-03T04:44:00.904275576+00:00 stderr F {"ts":1738557840904.059,"logger":"UnhandledError","caller":"resourcequota/resource_quota_controller.go:446","msg":"Unhandled Error","err":"unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: stale GroupVersion discovery: metrics.k8s.io/v1beta1", "error_code": "ERR002"}
    ```

- my fluentd config looks like this and looks pretty solid:
  
  - ```yaml
    <source>
      @type tail
      path /var/log/test.log
      pos_file /var/log/fluentd/cursor/k8s.log.pos
      tag kubernetes.logs
      read_from_head true
      <parse>
        @type cri
        merge_cri_fields false
        <parse>
          @type json
        </parse>
      </parse>
    </source>
    
    
    <filter kubernetes.logs>
      @type error_lookup
      error_codes_file /etc/fluent/fluent.d/error_codes.json
    </filter>
    
    <match kubernetes.logs>
      @type stdout
    </match>
    
    
    ```

- then we put our ruby script like this:
  
  - at this directory: `/etc/fluent/plugin/filter_error_lookup.rb`
    
    ```ruby
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
    ```

- final result looks like sth like this:
  
  - when matching the error code:
    
    ```json
    2025-04-06 12:05:36.906610095 -0400 kubernetes.logs: {"ts":1738557840904.059,"logger":"UnhandledError","caller":"resourcequota/resource_quota_controller.go:446","msg":"Unhandled Error","err":"unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: stale GroupVersion discovery: metrics.k8s.io/v1beta1","error_code":"ERR003","error_code_message":"Timeout while processing request"}
    ```
  
  - when not matchin error code:
    
    ```json
    2025-04-06 12:05:26.507598382 -0400 kubernetes.logs: {"ts":1738557840904.059,"logger":"UnhandledError","caller":"resourcequota/resource_quota_controller.go:446","msg":"Unhandled Error","err":"unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: stale GroupVersion discovery: metrics.k8s.io/v1beta1","error_code":"ERR0011","error_code_message":null}
    ```
  
  - and when the key `error_code` is not present at all:
    
    ```json
    2025-04-06 12:05:00.099294272 -0400 kubernetes.logs: {"ts":1738557840904.059,"logger":"UnhandledError","caller":"resourcequota/resource_quota_controller.go:446","msg":"Unhandled Error","err":"unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: stale GroupVersion discovery: metrics.k8s.io/v1beta1"}
    ```




