# Web Stack Debugging #4

This project fixes Nginx performance issues caused by low file descriptor limits.

The Puppet manifest increases the open-file limit and worker connections to handle high traffic.

Test using:

`ab -c 100 -n 2000 localhost/`
