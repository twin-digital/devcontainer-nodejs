#!/bin/sh

# This script is executed inside a container running the new version of this image after it is built, 
# and can be used to verify the image has been configured correctly.

# test installed packages
ls /home/devuser/.nvm > /dev/null || ( echo "'nvm' not installed"; exit 1 )
