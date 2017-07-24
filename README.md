# Docker google-drive-ocamlfuse
* Docker image to mount a google drive with google-drive-ocamlfuse shared with host.
* A fork from mitcdh/docker-google-drive-ocamlfuse

### Usage
* Instructions in http://allskyee.blogspot.com/2017/03/google-drive-as-docker-container.html
````
docker run -d \
--name google-drive \
--user rancher:rancher \
--security-opt apparmor:unconfined \
--cap-add mknod \
--cap-add sys_admin \
--device=/dev/fuse \
-v /path/to/host/google-drive:/mnt/google-drive:shared \
google-drive
````

### Structure
* `/mnt/google-drive`: Google Drive Fuse mount directory inside container
