# Fix Nginx limits for high traffic

exec { 'increase-nginx-ulimit':
  command => "/bin/sed -i 's/^ULIMIT=.*/ULIMIT=\"-n 4096\"/' /etc/default/nginx",
  unless  => '/bin/grep -q "^ULIMIT=.*4096" /etc/default/nginx',
}

exec { 'increase-worker-file-limit':
  command => "/bin/sed -i '/^worker_processes/a worker_rlimit_nofile 4096;' /etc/nginx/nginx.conf",
  unless  => '/bin/grep -q "^ULIMIT=.*4096" /etc/default/nginx',
}

exec { 'increase-worker-connections':
  command => "/bin/sed -i 's/worker_connections 768;/worker_connections 4096;/' /etc/nginx/nginx.conf",
  unless  => '/bin/grep -q "^ULIMIT=.*4096" /etc/default/nginx',
}

exec { 'restart-nginx':
  command => '/usr/sbin/service nginx restart',
  require => [
    Exec['increase-nginx-ulimit'],
    Exec['increase-worker-file-limit'],
    Exec['increase-worker-connections'],
  ],
}
