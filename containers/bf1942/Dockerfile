######## BUILDER ########

# Set the base image
FROM ubuntu:20.04 as builder

# Set environment variables
ENV USER root
ENV HOME /data
ENV FILE https://download.fieldfuckers.nl/servers/bf1942.zip

# Set working directory
WORKDIR $HOME

# Install prerequisites
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl tar unzip

# Donload and unpack installer
RUN curl $FILE --output archive.zip --silent \
 && unzip archive.zip \
 && rm archive.zip

######## INSTALL ########

# Set the base image
FROM ubuntu:20.04

# File Author / Maintainer
LABEL maintainer="Lanlords"

# Set environment variables
ENV USER bf1942
ENV HOME /data

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends libncurses5:i386 libc6-i386 libc6-dev-i386 \
 && rm -rf /var/lib/apt/lists/*

# Create the application user
RUN useradd -m -d $HOME $USER

# Copy game files from builder
COPY --from=builder --chown=bf1942:bf1942 /data $HOME

# Copy configuration and scripts
COPY --chown=bf1942:bf1942 scripts/bf1942_wrapper $HOME/bf1942_wrapper

# switch to user
USER $USER

# Expose required ports
EXPOSE 14567/udp 22000/udp

# Set working directory
WORKDIR $HOME

# Set default command
ENTRYPOINT ["/data/bf1942_wrapper"]
CMD ["+dedicated", "+statusMonitor", "1"]
