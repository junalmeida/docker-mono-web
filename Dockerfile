FROM mono:slim

LABEL maintainer="Marcos Junior <junalmeida@gmail.com>"

RUN apt-get update \
  && apt-get install -y binutils curl mono-devel ca-certificates-mono fsharp mono-vbnc nuget referenceassemblies-pcl mono-fastcgi-server4 \
  && rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 9000

RUN echo "#!/bin/sh\nfastcgi-mono-server4 --appconfigdir=/etc/mono/pools --socket=tcp:\$(ip -4 addr show eth0| grep -Po 'inet \K[\d.]+'):9000 --printlog" > /opt/mono-fastcgi

RUN chmod +x /opt/mono-fastcgi

EXPOSE 9000

ENTRYPOINT [ "/opt/mono-fastcgi" ]
