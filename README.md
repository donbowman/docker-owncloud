This is a docker container with owncloud. The owncloud files are stored in a volume (to persist) as is the owncloud config.
It uses an external mysql.

## Running ##

docker build -t owncloud .

docker run -d -p 127.0.0.1:4000:80 --name="owncloud" -v /var/lib/owncloud/data:/var/www/owncloud/data -v /var/lib/owncloud/config:/var/www/owncloud/config owncloud

And then setup a reverse proxy (using nginx or other). Below is the config for nginx:

```
server {
     listen 80;
     server_name owncloud.example.com;
     return 301 https://$host$request_uri;
}

server {
    listen 443;
    server_name owncloud.example.com;
    ssl on;
    ssl_certificate /etc/ssl/private/example_com.cert;
    ssl_certificate_key /etc/ssl/private/example_com.key;
    location / {
        proxy_pass http://127.0.0.1:4000;
        proxy_redirect off;
        proxy_buffering off;
        proxy_set_header 	Host	$host;
        proxy_set_header 	X-Real-IP	$remote_addr;
        proxy_set_header	X-Forwarded-For	$proxy_add_x_forwarded_for;
    }
}```
