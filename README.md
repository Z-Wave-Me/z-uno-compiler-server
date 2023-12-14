# Z-Uno Compilation Server

Docker container for building Z-Uno sketches

# Usage

```
rmdir -R sketch && mkdir -p sketch/tmp
# copy your sketch to sketch/tmp/tmp.ino
docker run -v $(pwd)/sketch:/sketch -it z-uno-compilation-server bash /build/compile.sh
# output file is in sketch/tmp/tmp_ino_signed.bin
# log in sketch/tmp/log.txt
# compiler exit code in sketch/tmp/status.txt
```

# Building the container

```sh
docker build . -t z-uno-compilation-server
```
