# To build, cd to this directory, then:
#   docker build --build-arg GITHUB_PAT=${GITHUB_PAT} -t rstudio/shinycoreci:base-3.6-bionic .
#   docker build --build-arg GITHUB_PAT=${GITHUB_PAT} --build-arg RELEASE=xenial -t rstudio/shinycoreci:base-3.6-xenial .
#

ARG R_VERSION=3.6

# bionic, xenial
ARG RELEASE=bionic
FROM rstudio/r-base:${R_VERSION}-${RELEASE}
ARG RELEASE=bionic

MAINTAINER Barret Schloerke "barret@rstudio.com"

# Don't print "debconf: unable to initialize frontend: Dialog" messages
ARG DEBIAN_FRONTEND=noninteractive

# Prep
RUN apt-get update && apt-get install -y \
  software-properties-common \
  locales \
  wget \
  apt-utils

# Create docker user with empty password (will have uid and gid 1000)
RUN useradd --create-home --shell /bin/bash docker \
  && passwd docker -d \
  && adduser docker sudo

RUN locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8


####
# R
####

# Test
RUN R --version
RUN Rscript --version

####
# TeX
####

# Install TinyTeX (subset of TeXLive)
RUN apt-get update && apt-get install -y \
  texinfo
# From FAQ 5 and 6 here: https://yihui.name/tinytex/faq/
# Also install ae, parskip, and listings packages to build R vignettes
RUN wget -qO- \
  "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
  sh -s - --admin --no-path \
  && ~/.TinyTeX/bin/*/tlmgr path add \
  && tlmgr install metafont mfware inconsolata tex ae parskip listings \
  && tlmgr path add \
  && Rscript -e "source('https://install-github.me/yihui/tinytex'); tinytex::r_texmf()"

# This is necessary for non-root users to follow symlinks to /root/.TinyTeX
RUN chmod 755 /root


# =====================================================================
# Shiny Server
# =====================================================================

EXPOSE 3838

# installer - gdebi wget
# cairo device - libcairo2-dev
# libcurl - libcurl4-gnutls-dev
# openssl - libssl-dev
# X11 toolkit intrinsics library - libxt-dev
# markdown - pandoc pandoc-citeproc
RUN apt-get update && apt-get install -y \
  gdebi wget \
  libcairo2-dev \
  libcurl4-gnutls-dev \
  libssl-dev \
  libxt-dev \
  pandoc pandoc-citeproc

####
# Common
####
RUN apt-get update && apt-get install -y \
  less \
  vim-tiny


####
# RSPM
####

# set up R to point to latest binary cran
RUN echo "options(\n\
  repos = c(CRAN = 'https://demo.rstudiopm.com/cran/__linux__/${RELEASE}/latest'),\n\
  download.file.method = 'libcurl',\n\
  # Detect number of physical cores\n\
  Ncpus = parallel::detectCores(logical=FALSE)\n\
  )" >> `Rscript -e "cat(R.home())"`/etc/Rprofile.site

RUN R -e 'source("https://demo.rstudiopm.com/__docs__/admin/check-user-agent.R")'

###
# shinycoreci
###

ARG GITHUB_PAT=NOTSUPPLIED
# make sure the variable persists
ENV GITHUB_PAT=$GITHUB_PAT
ARG SHINYCORECI_SHA=docker
ARG APPS_SHA=master


RUN R --quiet -e "install.packages('remotes')"
RUN R --quiet -e "remotes::install_cran(c('shinytest'))"

# install testing repo at specific sha
RUN R --quiet -e "remotes::install_github('rstudio/shinycoreci@${SHINYCORECI_SHA}', auth_token ='${GITHUB_PAT}')"


###
# shinycoreci-apps
###

# Download the repo in a temp folder, then unzip it into the home folder
RUN mkdir -p /tmp/apps_repo && \
  cd /tmp/apps_repo && \
  wget --no-check-certificate -O _apps.zip https://github.com/rstudio/shinycoreci-apps/archive/${APPS_SHA}.zip && \
  unzip _apps.zip -d . && \
  mv */* ~

# list the folders to see that it worked
RUN ls -alh ~ && echo '' &&  ls -alh ~/apps

# install R pkg system requirements
# Must use `~/apps` as default working directory is not `~`
RUN R --quiet -e "system(print(shinycoreci::rspm_all_install_scripts('~/apps', docker_release = '${RELEASE}')))"
# install r pkgs
RUN R --quiet -e "shinycoreci:::update_packages_installed('~/apps', update_pkgs = 'all')"


COPY retail.c _retail.c
RUN gcc _retail.c -o /usr/bin/retail
RUN chmod +x /usr/bin/retail

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/bin/bash", "/usr/bin/shiny-server.sh"]
