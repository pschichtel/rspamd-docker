bind_socket = "*:11334";

{% if env.PASSWORD_HASH %}
password = "{= env.PASSWORD_HASH =}";
{% endif %}

