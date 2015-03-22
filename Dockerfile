# r-base image is debin-based
FROM r-base
MAINTAINER mazzy <apocalipse89@gmail.com>

RUN apt-get update
RUN apt-get install -y sudo

#Install OpenSSL
RUN wget http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb
RUN dpkg -i libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

# Install RStudioServer
RUN apt-get install -y gdebi-core
RUN wget http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb
RUN gdebi -n rstudio-server-0.98.1103-amd64.deb

RUN rm liblibssl0.9.8_0.9.8o-4squeeze14_amd64.deb rstudio-server-0.98.1103-amd64.deb

# Define 'rstudio' server and add it to the
# rstudio-server group created during rstudio inst
RUN useradd -g rstudio-server rstudio && \
    echo "rstudio:rstudio" | chpasswd \
    adduser rstudio sudo

EXPOSE 8787
