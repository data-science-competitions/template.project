# R Package Development: Core --------------------------------------------------
FROM rocker/tidyverse:4.0.0

# Setup ------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    dos2unix \
    libcurl4-openssl-dev \
    libssl-dev \
	libxt-dev \
    libxml2-dev \
    libpq-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure RStudio Server -----------------------------------------------------
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2020-04-24\'
RUN echo "options(repos = ${R_REPOS})" > .Rprofile
RUN R -q -e "if(!require(remotes)) install.packages('remotes')"
RUN R -q -e "remotes::install_cran(c('profvis', 'renv', 'tinytex'))"
RUN R -q -e "remotes::install_cran(c('devtools', 'testthat', 'covr', 'roxygen2'))"
RUN R -q -e "tinytex::install_tinytex()"

# R Dependency Management ------------------------------------------------------
## Use {renv}
ENV RENV_PATHS_CACHE /renv/cache
ARG RENV_VERSION=0.12.0
RUN echo "options(renv.settings = list(snapshot.type = 'explicit'))" > .Rprofile
RUN echo "options(renv.settings = list(use.cache = TRUE))" >> .Rprofile
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
COPY ./DESCRIPTION ./renv.lock ./
RUN R -q -e 'renv::consent(TRUE); renv::restore()'

## Use {remotes}
RUN echo "options(repos = ${R_REPOS})" > .Rprofile
RUN R -q -e "remotes::install_deps(dependencies = 'Depends',  upgrade = FALSE)"
RUN R -q -e "remotes::install_deps(dependencies = 'Imports',  upgrade = FALSE)"
RUN R -q -e "remotes::install_deps(dependencies = 'Suggests', upgrade = FALSE)"

# Run RStudio Server -----------------------------------------------------------
ENV HOME /home/rstudio
ENV R_USER /home/rstudio
RUN printenv >> .env
RUN cp .env home/rstudio/.Renviron
RUN chown rstudio:rstudio home/rstudio/
ENV PASSWORD 1234
ENV ROOT true
