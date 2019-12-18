bind_socket = "*:11334";

{% if env.RSPAMD_PASSWORD_HASH %}
password = "{= env.RSPAMD_PASSWORD_HASH =}";
{% endif %}

