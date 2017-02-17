#!/bin/bash

docker build -t dhcom-builder docker
docker run -v $(pwd):/src --privileged -it dhcom-builder

exit $?
