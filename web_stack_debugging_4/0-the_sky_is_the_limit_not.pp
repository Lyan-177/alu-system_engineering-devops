exec { 'fix-nginx-file-limits':
  command => 'sed -i "s/ULIMIT=\"-n 15\"/ULIMIT=\"-n 4096\"/" /etc/default/nginx && sed -i "/^worker_processes/a worker_rlimit_nofile 4096;" /etc/nginx/nginx.conf && sed -i "s/worker_connections 768;/worker_connections 1024;/" /etc/nginx/nginx.conf && service nginx restart',
  unless  => 'grep -q "ULIMIT=\"-n 4096\"" /etc/default/nginx && grep -q "worker_rlimit_nofile 4096;" /etc/nginx/nginx.conf && grep -q "worker_connections 1024;" /etc/nginx/nginx.conf',
  path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
}
