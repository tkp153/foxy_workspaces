#!/bin/bash
docker run \
--name workspace_2022 \
--shm-size 2048m \
--privileged \
-it workspace:1.0 /bin/bash