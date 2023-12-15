# LabOne Docker images

This [GitHub repo](https://github.com/zhinst/labone-docker) hosts the Dockerfile generating Linux Docker images of LabOne. The
supported architectures are `Linux/amd64` and `Linux/arm64`.

## Dockerfile usage
You can build the image you need with the following command:

```
docker buildx build . --platform <platform> \
                      --target <target> \
                      --build_args LABONE_VERSION=<version> \
                      --tag <tag>
```

- `--platform` should be `Linux/amd64` or `Linux/arm64`.

- `--target` should be one of `labone_dataserver`, `labone_webserver`, or
  `labone_full`. If omitted, it defaults to `labone_full`.

- `LABONE_VERSION` should be one of the officially released LabOne versions,
  starting with 23.02.42414.

- `--tag` is the [Docker tag](https://docs.docker.com/engine/reference/commandline/build/#tag)

## Images

Pre-built images can be found at Docker Hub under the [zhinst/labone](https://hub.docker.com/r/zhinst/labone) repository.

### LabOne Data Server

This image contains only the LabOne Data Server and the device firmware
packages. The [`ENTRYPOINT`](https://docs.docker.com/engine/reference/builder/#entrypoint) of this image is the LabOne Data Server.

Available Docker tags : `<LABONE_VERSION>-dataserver`, `<LABONE_SHORT_VERSION>-dataserver`

To run the Data Server, you can use the following command:
```
docker run -d --rm --name labone-dataserver \
           --network=host \
           zhinst/labone:23.10-dataserver
```

We recommend using `--network=host` to avoid port mapping issues. The Data
Server relies on multicast to discover devices in the same network. By default,
Docker containers are started in a bridged `docker` network, which renders
devices invisible to the Data Server. Please [get in
touch](mailto:support@zhinst.com) if you need assistance with use cases that
requires different network configuration.

### LabOne Web Server

This image contains all of the above plus the LabOne documentation and
the LabOne Web Server, which serves as the image's [`ENTRYPOINT`](https://docs.docker.com/engine/reference/builder/#entrypoint).

Available Docker tags : `<LABONE_VERSION>-webserver`, `<LABONE_SHORT_VERSION>-webserver`

To run the Web Server, you can use the following command:
```
docker run -d --rm --name labone-webserver \
           --network=host \
           zhinst/labone:23.10-webserver
```

Also here, we recommend using `--network=host` to avoid port mapping issues.
The Web Server relies on multicast to find Data Servers in the network.

### LabOne All-in-One image
This images contains the full installation of LabOne, plus Python and
[`zhinst-core`](https://pypi.org/project/zhinst-core/). The [`ENTRYPOINT`](https://docs.docker.com/engine/reference/builder/#entrypoint) is a
[shell script](https://github.com/zhinst/labone-docker/blob/main/start.sh) starting both LabOne Web Server (in background) and
Data Server.

Available Docker tags: `<LABONE_VERSION>-full`, `<LABONE_SHORT_VERSION>-full`

To run the LabOne All-in-One image, you can use the following command:
```
docker run -d --rm --name labone-full \
           --network=host \
           zhinst/labone:23.10-full
```