#!/bin/bash
# Note this does not remove the data written to the sqlvolume so it will be there when you restart
docker rm -vf mariadb

# if you do want to wipe your saved data and start again, you can uncomment and run the following command
# docker volumn rm sqlvolume