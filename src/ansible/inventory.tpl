[api_gw]
API-GW_IP_PLACEHOLDER ansible_user=API_GW_USER 

[eureka_server]
EUREKA_SERVER_IP_PLACEHOLDER ansible_user=EUREKA_USER ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -W %h:%p -q API_GW_USER@API-GW_IP_PLACEHOLDER"'