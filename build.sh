set -e
rm -rf _build/
docker build -t build .
docker cp $(docker create --name tc build):/home/app/build ./_build && docker rm tc
rm -rf build/ && mv _build/ build/
