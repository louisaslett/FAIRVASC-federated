# Start from the default Github Codespaces image, see https://github.com/devcontainers/images/tree/main/src/universal
FROM mcr.microsoft.com/devcontainers/universal:2.2.9-focal

# Install R, see https://cran.r-project.org/bin/linux/ubuntu/#install-r
# We also add the Posit Package Manager repo and enable headers for binary packages, see https://packagemanager.rstudio.com/__docs__/admin/serving-binaries/#binary-user-agents
RUN apt update -qq \
    && apt install --no-install-recommends software-properties-common dirmngr \
    && wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
    && add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt install --no-install-recommends r-base \
    && echo -E 'options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))' >> /etc/R/Rprofile.site \
    && echo -E 'options(POSIT = "https://packagemanager.rstudio.com/cran/__linux__/focal/latest")' >> /etc/R/Rprofile.site
