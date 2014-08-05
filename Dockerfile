FROM debian:jessie

RUN apt-get update && apt-get install -y git make

CMD git clone https://github.com/docker/docker.git && cd /docker && \
    docker build -t docker . && \
    docker run --name nightly-build --privileged docker hack/make.sh binary cross && \
    docker cp nightly-build /docker/bundles:/ && \
    docker rm -v nightly-build
