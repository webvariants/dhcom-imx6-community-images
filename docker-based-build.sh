#!/bin/bash

docker build -t dhcom-builder docker
docker run -v /dev:/dev -v $(pwd):/src --privileged -it dhcom-builder

exit $?
