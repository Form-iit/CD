[api_gw]
API-GW_IP_PLACEHOLDER ansible_user=API_GW_USER ansible_ssh_private_key_file=SSH_PRIVATE_KEY_PATH

[eureka_server]
EUREKA_SERVER_IP_PLACEHOLDER ansible_user=EUREKA_USER ansible_ssh_private_key_file=SSH_PRIVATE_KEY_PATH ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -i SSH_PRIVATE_KEY_PATH -W %h:%p -q EUREKA_USER@API-GW_IP_PLACEHOLDER"'

[config_server]
CONFIG_SERVER_IP_PLACEHOLDER ansible_user=CONFIG_SERVER_USER ansible_ssh_private_key_file=SSH_PRIVATE_KEY_PATH ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -i SSH_PRIVATE_KEY_PATH -W %h:%p -q CONFIG_SERVER_USER@API-GW_IP_PLACEHOLDER"'