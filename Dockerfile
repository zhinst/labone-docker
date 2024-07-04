ARG LABONE_VERSION=24.04.60606
ARG LABONE_BASE_URL=https://download.zhinst.com/${LABONE_VERSION}


FROM alpine:latest AS builder

RUN apk --no-cache add curl tar

ARG TARGETARCH
ARG LABONE_VERSION
ARG LABONE_BASE_URL
COPY download_and_unpack_labone.sh .
RUN chmod +x download_and_unpack_labone.sh \
	&& ./download_and_unpack_labone.sh


FROM ubuntu:22.04 as labone_base

COPY --from=builder LabOneLinux*/DataServer ./labone/DataServer/
COPY --from=builder LabOneLinux*/Firmware ./labone/Firmware/


FROM labone_base as labone_dataserver

EXPOSE 8001 8003 8004 41000-41100
ENTRYPOINT ["/labone/DataServer/ziDataServer"]


FROM labone_base as labone_webserver

COPY --from=builder LabOneLinux*/WebServer ./labone/WebServer/
COPY --from=builder LabOneLinux*/Documentation ./labone/Documentation/
EXPOSE 8006
ENTRYPOINT ["/labone/WebServer/ziWebServer"]


FROM labone_webserver as labone_full

RUN apt-get update \
	&& apt-get install -y curl python3-pip \
	&& rm -rf /var/lib/apt/lists/* \
	&& pip install numpy typing-extensions

COPY --from=builder LabOneLinux*/API ./labone/API/

ARG TARGETARCH
ARG LABONE_VERSION
ARG LABONE_BASE_URL
COPY download_and_install_zhinst_core.sh start.sh ./
RUN chmod +x download_and_install_zhinst_core.sh \
	&& ./download_and_install_zhinst_core.sh \
	&& rm -f download_and_install_zhinst_core.sh \
	&& chmod +x start.sh

EXPOSE 8001 8003 8004 8006 41000-41100
ENTRYPOINT ["/start.sh"]
