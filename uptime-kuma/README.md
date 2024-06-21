### webhook 配置

自定义内容

```json
{
    "event_title": "UptimeKuma 监控",
    "event_name": "{{ monitorJSON['name'] }} {% if heartbeatJSON['status'] == 1 %}✅ Up{% else %}🔴 Down{% endif %}",
    "event_type": "{% if heartbeatJSON['status'] == 1 %}恢复{% else %}告警{% endif %}",
    "event_level": "{% if heartbeatJSON['status'] == 1 %}通知{% else %}警告{% endif %}",
    "event_time": "{{ heartbeatJSON['time'] }}",
    "event_content": "{{ heartbeatJSON['msg'] }}\n > **监控url:** {{ monitorJSON['url'] }}"
}
```

额外header

```json
{
	"Content-Type": "application/json"
}
```

