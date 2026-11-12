# Increase Nginx limits to handle high traffic

exec { 'increase-nginx-ulimit':
  command => "/bin/sed -i 's/ULIMIT=\"-n 15\"/ULIMIT=\"-n 4096\"/' /etc/default/nginx",
  unless  => '/bin/grep -q 4096 /etc/default/nginx',
}

exec { 'increase-worker-file-limit':
  command => "/bin/sed -i '/^worker_processes/a worker_rlimit_nofile 4096;' /etc/nginx/nginx.conf",
  unless  => '/bin/grep -q worker_rlimit_nofile /etc/nginx/nginx.conf',
}

exec { 'increase-worker-connections':
  command => "/bin/sed -i 's/worker_connections 768;/worker_connections 4096;/' /etc/nginx/nginx.conf",
  unless  => '/bin/grep -q "worker_connections 4096;" /etc/nginx/nginx.conf',
}

exec { 'restart-nginx':
  command => '/usr/sbin/service nginx restart',
  require => [
    Exec['increase-nginx-ulimit'],
    Exec['increase-worker-file-limit'],
    Exec['increase-worker-connections'],
  ],
}
