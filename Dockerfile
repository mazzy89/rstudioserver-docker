# r-base image is debin-based
FROM r-base:latest
MAINTAINER mazzy <apocalipse89@gmail.com>

RUN apt-get -y -qq update \
    && wget -q http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb \
    && dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb && rm libssl0.9.8_0.9.8o-4squeeze14_amd64.deb \
    && apt-get install -y -qq sudo gdebi-core \
    && wget -q http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb \
    && gdebi -n rstudio-server-0.98.1103-amd64.deb && rm rstudio-server-0.98.1103-amd64.deb

RUN printf 'server-daemonize=0\nwww-address=0.0.0.0\nwww-port=8787\n' > \
    /etc/rstudio/rserver.conf

# Define default 'rstudio' user and add it to the
# rstudio-server group created during rstudio inst
RUN usermod -l rstudio docker \
    && usermod -m -d /home/rstudio rstudio \
    && groupmod -n rstudio docker \
    && echo "rstudio:rstudio" | chpasswd

EXPOSE 8787

ENTRYPOINT ["/usr/lib/rstudio-server/bin/rserver"]
