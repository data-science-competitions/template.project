# R Package Development---------------------------------------------------------
FROM rocker/tidyverse:4.0.0

# Setup ------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    dos2unix \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libpq-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python ---------------------------------------------------------------
ARG PYTHON_VER=3.7
RUN apt-get update && apt-get -y install python3.7 && \
    apt-get -y install python3-pip
RUN pip3 install virtualenv && pip3 install requests

# Configure RStudio Server -----------------------------------------------------
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2020-04-24\'
ARG MINICONDA_PATH=\'/home/rstudio/.local/share/r-miniconda\'
RUN echo "MINICONDA_PATH=$MINICONDA_PATH" >> .Renviron
RUN echo "options(repos = ${R_REPOS})" >> .Rprofile
RUN R -q -e "if(!require(remotes)) install.packages('remotes')"
RUN R -q -e "remotes::install_cran(c('profvis', 'renv', 'reticulate'))"
RUN R -q -e "remotes::install_cran(c('devtools', 'testthat', 'covr', 'roxygen2'))"
RUN R -q -e "try(reticulate::install_miniconda(${MINICONDA_PATH}, update = FALSE))"

# Install Metaflow -------------------------------------------------------------
ARG METAFLOW_VER='2.2.0'
RUN echo "METAFLOW_VER=$METAFLOW_VER" >> .Renviron
RUN R -q -e "remotes::install_github('Netflix/metaflow', ${METAFLOW_VER}, 'R')"
RUN R -q -e "metaflow::install(user_install = FALSE, upgrade = FALSE)"

# Install MLflow ---------------------------------------------------------------
ARG MLFLOW_VER='1.8.0'
ARG MLFLOW_URI=\'/home/rstudio/.local/share/mlflow\'
RUN echo "MLFLOW_CONDA_HOME=$MINICONDA_PATH" >> .Renviron && \
    echo "MLFLOW_URI=$MLFLOW_URI" >> .Renviron && \
    echo "MLFLOW_VER=$MLFLOW_VER" >> .Renviron
RUN mkdir -p ${MLFLOW_URI}
RUN R -q -e "remotes::install_version('mlflow', ${MLFLOW_VER})"
RUN R -q -e "mlflow::install_mlflow(python_version = '${PYTHON_VER}')"

# Install Project Dependencies -------------------------------------------------
COPY ./DESCRIPTION ./DESCRIPTION
RUN R -q -e "remotes::install_deps(dependencies = 'Depends')"
RUN R -q -e "remotes::install_deps(dependencies = 'Imports')"
RUN R -q -e "remotes::install_deps(dependencies = 'Suggests')"

# Run RStudio Server -----------------------------------------------------------
RUN mv .Renviron home/rstudio/
RUN chown rstudio:rstudio home/rstudio/
ENV PASSWORD 1234
ENV ROOT true



