# Base Image from https://hub.docker.com/u/rocker
FROM rocker/shiny:latest

# System libraries of general use
# Install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadb-dev \
    libpq-dev \
    libssl-dev

## Update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

RUN R -e "install.packages(pkgs=c('shiny','tidyverse','shinythemes'), repos='https://cran.rstudio.com/')" 

RUN mkdir /root/app

COPY app.R /root/shiny_save

EXPOSE 3838

# RUN 
CMD ["R", "-e", "shiny::runApp('/root/shiny_save', host='0.0.0.0', port=3838)"]
