# Docker google-drive-ocamlfuse
* Docker image to mount a google drive with google-drive-ocamlfuse shared with host.

### Environment Variables
* `CLIENT_ID`: Google oAuth client ID without trailing `.apps.googleusercontent.com`
* `CLIENT_SECRET`: Google oAuth client secret
* `VERIFICATION_CODE`: Google oAuth verification code obtained from the following URL with client_id substituted: `https://accounts.google.com/o/oauth2/auth?client_id=${CLIENT_ID}.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&response_type=code&access_type=offline&approval_prompt=force"`

### Host Configuration
1. If using systemd to manage the docker daemon process make sure that the service is configured either explicitly with a `shared` mountflag or un-configured and defaults to `shared`.
2. The mount point will also need to have it's propagation explicitly marked as shared.

Without this the fuse mount will not propagate back to the host.

````
# Ensure docker daemon uses shared mount flags
sed -i 's/MountFlags=slave/#MountFlags=shared/' /etc/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker.service

# Specify the mount points propagation as shared
mount --bind /mnt/drive /mnt/drive
mount --make-shared /mnt/drive
````

### Usage
````
docker run -d \
-e CLIENT_ID='my-client-id' \
-e CLIENT_SECRET='my-client-secret' \
-e VERIFICATION_CODE='my-verification-code' \
--security-opt apparmor:unconfined \
--cap-add mknod \
--cap-add sys_admin \
--device=/dev/fuse \
-v /mnt/drive:/mnt/gdrive:shared \
mitcdh/google-drive-ocamlfuse
````

### Structure
* `/mnt/gdrive`: Google Drive Fuse mount directory inside container