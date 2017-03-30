FROM ubuntu:xenial

MAINTAINER connorxxl <christian.flaig@gmail.com>

RUN apt update && \
    apt full-upgrade -y && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list && \
    apt update && \
    apt install -y mono-devel mediainfo sqlite3 libmono-cil-dev wget curl && \
    apt-get -y autoremove && \
    apt-get -y clean


RUN cd /tmp && \
    wget https://github.com/Radarr/Radarr/releases/download/v0.2.0.535/Radarr.develop.0.2.0.535.linux.tar.gz && \
    tar -xf Radarr* -C /opt/


EXPOSE 7878

VOLUME ["/config"]
VOLUME ["/volumes/complete"]
VOLUME ["/volumes/movies"]

WORKDIR /opt/Radarr

ENTRYPOINT ["mono", "/opt/Radarr/Radarr.exe"]
CMD [ "-nobrowser", "-data=/config" ]
