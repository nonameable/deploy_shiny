# Use an existing image
# as a base
FROM ubuntu:latest

# Download and install a dependency

## prepare
RUN apt-get update
RUN apt-get upgrade -y
## add CRAN source for latest R
RUN apt update && apt -y install add-apt-key software-properties-common \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
    && apt-add-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"
## if you install r-base-dev directly, it would ask you to choose timezone and cause timeout
RUN apt update && apt -y install tzdata && rm -r /var/lib/apt/lists/
RUN echo "America/Bogota" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN apt update

RUN apt install r-base -y

## common system dependencies for R packages
RUN apt update && apt -y install libcurl4-openssl-dev libssl-dev libxml2-dev libcairo2-dev && rm -r /var/lib/apt/lists/

## create folder for deploy
RUN mkdir "deploy"
RUN cd "deploy" && touch ".Rprofile"

# Tell the image what to do
# when it starts as a container
CMD ["ls"]