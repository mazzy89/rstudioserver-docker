FROM ubuntu:latest
MAINTAINER mazzy

# Install R
RUN echo 'deb http://cran.cnr.berkeley.edu/bin/linux/ubuntu trusty/' >> \
          /etc/apt/sources.list
RUN apt-get update
RUN apt-get install --force-yes -y r-base

# Install RStudioServer
RUN apt-get install -y gdebi-core \
                      libapparmor1  \
                      wget
RUN wget http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb
RUN gdebi rstudio-server-0.98.1103-amd64.deb

EXPOSE 8787
