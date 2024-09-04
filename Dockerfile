FROM rocker/shiny-verse:4.2.2

# system libraries of general use
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    vim 

#Install Packages
RUN R -e 'install.packages(c("shiny", "googleway"), repos="http://cran.rstudio.com", dependencies = TRUE)'

#Copy App
COPY ./app/ /srv/shiny-server/
#COPY start.R /srv/shiny-server/start.R

#COPY .Renviron /usr/local/lib/R/etc/.myRenviron
#RUN cat /usr/local/lib/R/etc/.myRenviron >> /usr/local/lib/R/etc/Renviron

COPY ./shiny-server.conf /etc/shiny-server/shiny-server.conf

EXPOSE 3838

#run App
CMD ["/usr/bin/shiny-server"]
#CMD ["Rscript", "/srv/shiny-server/start.R"]
#CMD ["R", "-e", "shiny::runApp('/usr/bin/shiny-server', host='0.0.0.0', port=3838)"]
