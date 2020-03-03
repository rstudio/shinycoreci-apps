# To build, cd to this directory, then:
#   docker build --build-arg SSP_LICENSE="$(cat ssp-rstudio-license-2024-09-06.lic)" -t rstudio/shinycoreci:ssp-3.6-centos7 .
#
# To run:
#   docker run --rm -p 7979:3838 --name ssp_centos rstudio/shinycoreci:ssp-3.6-centos7

ARG R_VERSION=3.6
ARG RELEASE=centos7
FROM rstudio/shinycoreci:base-${R_VERSION}-${RELEASE}
ARG R_VERSION=3.6
ARG RELEASE=centos7
ARG AWS_BUILD_MACHINE=centos6.3

RUN yum install -y \
  openssl \
  psmisc

# =====================================================================
# Shiny Server
# =====================================================================

# Download and install shiny server
RUN wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-pro-build/${AWS_BUILD_MACHINE}/x86_64/VERSION" -O "version.txt" && \
  VERSION=$(cat version.txt)  && \
  wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-pro-build/${AWS_BUILD_MACHINE}/x86_64/shiny-server-commercial-$VERSION-redhat-x86_64.rpm" -O ss-latest.rpm && \
  yum install -y ss-latest.rpm && \
  rm -f ssp-latest.rpm && \
  rm /srv/shiny-server/index.html

# activate license
ARG SSP_LICENSE
RUN /opt/shiny-server/bin/license-manager activate ${SSP_LICENSE} > /dev/null

RUN echo "${R_VERSION}-${RELEASE} Shiny Server PRO: `cat version.txt`\n" >> /srv/shiny-server/__version && \
  rm -f version.txt

RUN yum clean all
