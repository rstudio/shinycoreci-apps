# To build, cd to this directory, then:
#   docker build -t rstudio/shinycoreci:sso-3.6-centos7 .
#
# To run:
#   docker run --rm -p 7878:3838 --name sso_centos rstudio/shinycoreci:sso-3.6-centos7

ARG R_VERSION=3.6
FROM rstudio/shinycoreci:base-${R_VERSION}-centos7
ARG R_VERSION=3.6


# =====================================================================
# Shiny Server
# =====================================================================

# Download and install shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/centos6.3/x86_64/VERSION -O "version.txt" && \
  VERSION=$(cat version.txt)  && \
  wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/centos6.3/x86_64/shiny-server-$VERSION-x86_64.rpm" -O ss-latest.rpm && \
  yum install -y ss-latest.rpm && \
  rm -f ssp-latest.rpm && \
  rm /srv/shiny-server/index.html





RUN echo "${R_VERSION}-centos7 Shiny Server Open Source: `cat version.txt`\n" >> /srv/shiny-server/__version && \
  rm -f version.txt


RUN yum clean all
