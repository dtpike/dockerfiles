## Usage
To build the image, run `docker build` and pass build arguments for base image and username. Example
```sh
$ docker build -t image_name:image_tag \
        --build-arg BASE=ubuntu/xenial \
        --build-arg USER=username \
        /path/to/dockerfile
```
