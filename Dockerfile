FROM r-base
MAINTAINER mazzy <apocalipse89@gmail.com>

# Install RStudioServer
RUN apt-get install -y gdebi-core \
                      libapparmor1  \
                      wget
RUN wget http://download2.rstudio.org/rstudio-server-0.98.1103-amd64.deb
RUN gdebi rstudio-server-0.98.1103-amd64.deb

EXPOSE 8787
