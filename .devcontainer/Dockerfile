# Start from the default Github Codespaces image, see https://github.com/devcontainers/images/tree/main/src/universal
FROM mcr.microsoft.com/devcontainers/universal:2-linux

# Install R, see https://cran.r-project.org/bin/linux/ubuntu/#install-r
# We also add the Posit Package Manager repo and enable headers for binary packages, see https://packagemanager.rstudio.com/__docs__/admin/serving-binaries/#binary-user-agents
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends software-properties-common dirmngr \
    && wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
    && add-apt-repository -y -u "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends r-base \
    && echo 'options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))' >> /etc/R/Rprofile.site \
    && echo 'options(repos = "https://packagemanager.rstudio.com/cran/__linux__/focal/latest")' >> /etc/R/Rprofile.site \
    && echo 'TZ="Europe/London"' >> /etc/R/Renviron.site

# Install R packages
RUN R -e "install.packages( c( \
      'tidyverse', \
      'bayestestR', \
      'rdflib' \
    ))"

# Install sysdeps for above R packages
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
      librdf0-dev \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y clean \
    && rm -rf /var/lib/apt/lists/*
