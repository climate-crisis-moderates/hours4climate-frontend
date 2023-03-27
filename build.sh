set -e
docker build -t build .
docker cp $(docker create --name tc build):/home/app/build ./build && docker rm tc
