# load_balancer

Scripts for building a redundant web stack: two web servers behind a load balancer.

- `0-custom_http_response_header`: Bash script that installs nginx and adds an `X-Served-By` response header containing the server's hostname. Used on web-01 and web-02.
