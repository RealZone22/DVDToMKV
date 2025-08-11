docker build -t dvd-mkv .

docker run --rm -it \
    --device /dev/sr0:/dev/sr0 \
    -v ./rips:/data/output \
    ripping
