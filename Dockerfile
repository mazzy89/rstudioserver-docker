# r-base image is debin-based
FROM r-base
MAINTAINER mazzy <apocalipse89@gmail.com>

RUN apt-get -y -qq update
RUN apt-get install -y -q sudo

#Install OpenSSL
RUN wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb && \
    dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

# Install RStudioServer
RUN apt-get install -y gdebi-core
RUN wget http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb && \
  gdebi -n rstudio-server-0.98.1103-amd64.deb

RUN rm libssl0.9.8_0.9.8o-4squeeze14_amd64.deb \
        rstudio-server-0.98.1103-amd64.deb

# Configure RStudioServer
RUN printf 'server-daemonize=0\nwww-address=0.0.0.0\nwww-port=8787\n' > \
    /etc/rstudio/rserver.conf

# Define default 'rstudio' user and add it to the
# rstudio-server group created during rstudio inst
RUN useradd -r -g rstudio-server rstudio && \
    echo "rstudio:rstudio" | chpasswd && \
    adduser rstudio sudo

EXPOSE 8787

ENTRYPOINT ["/usr/lib/rstudio-server/bin/rserver"]
