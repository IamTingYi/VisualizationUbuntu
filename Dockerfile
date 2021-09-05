# Example shiny app docker file

# get shiny server and R from the rocker project
FROM rocker/shiny:4.0.5

# system libraries
# Try to only install system libraries you actually need
# Package Manager is a good resource to help discover system deps
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev


# install R packages required
# Change the packages list to suit your needs
RUN R -e 'install.packages(c("shiny", "shinydashboard", "ggplot2", "dplyr"), \
          repos="https://packagemanager.rstudio.com/cran/__linux__/focal/2021-04-23"\
          )'


# copy the app directory into the image
RUN mkdir /srv/shiny-server/shiny1
COPY visualization_app /srv/shiny-server/shiny1
RUN mkdir /srv/shiny-server/shiny2
COPY linktest_app /srv/shiny-server/shiny2


# run app
CMD ["/usr/bin/shiny-server"]

