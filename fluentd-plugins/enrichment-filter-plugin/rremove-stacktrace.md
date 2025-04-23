we have a sample log like this:

```json
2025-02-03T04:44:00.904275576+00:00 stderr F {"ts":1738557840904.059,"logger":"UnhandledError","caller":"resourcequota/resource_quota_controller.go:446","msg":"Unhandled Error","err":"unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: stale GroupVersion discovery: metrics.k8s.io/v1beta1", "error_code": "ERR001","test_key": "11","stack_trace": "value-stack"}
```

we want to achieve these output:

- this one has log uuid to correlate with other log which has the exact stack_trace content:

```json
2025-04-21 13:57:21.792938155 -0400 kubernetes.logs: {"ts":1738557840904.059,"logger":"UnhandledError","caller":"resourcequota/resource_quota_controller.go:446","msg":"Unhandled Error","err":"unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: stale GroupVersion discovery: metrics.k8s.io/v1beta1","error_code":"ERR001","test_key":"11","log_uuid":"3d003fb9-0e7c-4d88-ac90-77080ec7d77f"}
```

- this one has log uuid and the stack_trac

```json
2025-04-23 02:34:29.725366399 -0400 kubernetes.logs: {"ts":1738557840904.059,"logger":"UnhandledError","caller":"resourcequota/resource_quota_controller.go:446","msg":"Unhandled Error","err":"unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: stale GroupVersion discovery: metrics.k8s.io/v1beta1","error_code":"ERR001","test_key":"11","log_uuid":"f21ca1e1-67dc-4546-8a36-1066b72f49ca","extracted_stack_trace":"value-stack-trace"}
```



our fluentd config looks like something like this:

```yaml
<source>
  @type tail
  path /var/log/res/aaaa.log
  pos_file /var/log/fluentd/cursor/k8s-1-prom.log.pos
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
  @type record_transformer
  enable_ruby true
  <record>
    log_uuid ${record["stack_trace"] ? (require 'securerandom'; SecureRandom.uuid) : nil}
  </record>
</filter>
<match kubernetes.logs>
  @type copy
  <store>
    @type relabel
    @label @stack_trace
  </store>
  <store>
    @type relabel
    @label @main_log
  </store>
</match>
<label @stack_trace>
  <filter kubernetes.logs>
    @type grep
    <regexp>
      key stack_trace
      pattern .+
    </regexp>
  </filter>
  <filter kubernetes.logs>
    @type record_transformer
    enable_ruby true
    <record>
      extracted_stack_trace ${record["stack_trace"]}
      log_uuid ${record["log_uuid"]}
    </record>
    remove_keys stack_trace
  </filter>
<match kubernetes.logs>
    @type stdout
  </match>
</label>
<label @main_log>
  <filter kubernetes.logs>
    @type record_transformer
    enable_ruby true
    remove_keys stack_trace
  </filter>
<match kubernetes.logs>
    @type stdout
  </match>
</label>
```
