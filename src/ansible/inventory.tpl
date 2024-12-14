[api_gw]
API-GW_IP_PLACEHOLDER

[eureka_server]
EUREKA_IP_PLACEHOLDER ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -i ~/.ssh/id_rsa API-GW_IP_PLACEHOLDER"'