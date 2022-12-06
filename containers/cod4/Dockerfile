######## BUILDER ########

# Set the base image
FROM ubuntu:20.04 as builder

# Set environment variables
ENV USER root
ENV HOME /data
ENV FILE https://download.fieldfuckers.nl/servers/cod4.zip

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
ENV USER cod4
ENV HOME /data

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends libstdc++5:i386 \
 && rm -rf /var/lib/apt/lists/*

# Create the application user
RUN useradd -m -d $HOME $USER

# Copy game files from builder
COPY --from=builder --chown=cod4:cod4 /data $HOME

# switch to user
USER $USER

# Expose required ports
EXPOSE 28960/udp 20510/udp

# Set working directory
WORKDIR $HOME

# Set default command
ENTRYPOINT $HOME/cod4_lnxded
CMD ["+set dedicated 1", "+set g_gametype sd", "+map_rotate", "+set sv_punkbuster 0", "+exec server.cfg"]
