[workers]
%{ for ip in worker_ips ~}
${ip}
%{ endfor ~}

[masters]
${master_ip}