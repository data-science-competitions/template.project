# R Package Development---------------------------------------------------------
FROM rocker/tidyverse:4.0.0

# Setup ------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    dos2unix \
    libssl-dev \
    libxml2-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure R ------------------------------------------------------------------
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2020-04-24\'
RUN echo "options(repos = ${R_REPOS})" >> .Rprofile
RUN R -q -e "if(!require(remotes)) install.packages('remotes')"
RUN R -q -e "remotes::install_cran(c('devtools', 'testthat', 'covr', 'roxygen2'))"

# Package Management System ----------------------------------------------------
ARG R_PACKAGE_NAME=sample-package
COPY ./DESCRIPTION ./${R_PACKAGE_NAME}/DESCRIPTION
WORKDIR /${R_PACKAGE_NAME}
RUN R -q -e "remotes::install_deps(dependencies = 'Depends')"
RUN R -q -e "remotes::install_deps(dependencies = 'Imports')"
RUN R -q -e "remotes::install_deps(dependencies = 'Suggests')"

# Prepare Package Files --------------------------------------------------------
COPY . /${R_PACKAGE_NAME}
RUN rm -rf .Rprofile

# Prepare Package Files --------------------------------------------------------
RUN R -q -e "devtools::check(error_on = 'error')"
RUN R -q -e "system.time({\
               devtools::load_all(export_all = FALSE, helpers = FALSE);\
               testthat::test_dir('./tests/testthat', stop_on_failure = TRUE)\
             })"
