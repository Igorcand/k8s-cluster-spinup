[masters]
${master_ip}

[workers]
%{ if has_workers ~}
%{ for ip in worker_ips ~}
${ip}
%{ endfor ~}
%{ else ~}
${worker_ips[0]}
%{ endif ~}
