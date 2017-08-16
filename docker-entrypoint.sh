#!/bin/sh

DRIVE_PATH=/mnt/google-drive

if [ -e ~/.gdfuse/default/config ]; then
	echo "existing google-drive-ocamlfuse config found"
	echo "mounting at ${DRIVE_PATH}"
	google-drive-ocamlfuse "${DRIVE_PATH}" -o nonempty
else
	echo "default config not found"
fi

tail -f /dev/null & wait
