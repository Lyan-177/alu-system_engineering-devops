# Fixes the typo that makes Apache return a 500 error
exec { 'fix-wordpress':
  command => 'sed -i s/class-wp-locale.phpp/class-wp-locale.php/ /var/www/html/wp-settings.php',
  path    => '/usr/local/bin/:/bin/'
}
