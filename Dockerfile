FROM mono:slim

MAINTAINER Marcos Junior <junalmeida@gmail.com>

RUN apt-get update \
  && apt-get install -y binutils curl mono-devel ca-certificates-mono fsharp mono-vbnc nuget referenceassemblies-pcl mono-fastcgi-server4 \
  && rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 9000

ENTRYPOINT [ "fastcgi-mono-server4" ]
CMD [ "--appconfigdir=/etc/mono/pools", "--socket=tcp:9000", "--printlog" ]
