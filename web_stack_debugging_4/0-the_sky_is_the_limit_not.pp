# Fix Nginx file descriptor limits under high traffic

exec { 'fix-nginx-limits':
  command => '/bin/sed -i s/15/4096/ /etc/default/nginx',
  unless  => '/bin/grep -q 4096 /etc/default/nginx',
}

exec { 'restart-nginx':
  command   => '/usr/sbin/service nginx restart',
  subscribe => Exec['fix-nginx-limits'],
}
