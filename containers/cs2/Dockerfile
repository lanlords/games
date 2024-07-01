######## INSTALL ########

# Set the base image
FROM steamcmd/steamcmd:debian-11

# File Author / Maintainer
LABEL maintainer="Lanlords"

# Set environment variables
ENV USER cs2
ENV HOME /data

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates lib32z1 libicu-dev \
 && rm -rf /var/lib/apt/lists/*

# Create the application user
RUN useradd -m -d $HOME $USER

# Download game files from steam
RUN steamcmd +login anonymous +force_install_dir $HOME \
    +app_update 730 validate +quit

# Copy steamclient.so
RUN mkdir -p $HOME/.steam/sdk32 $HOME/.steam/sdk64 \
 && cp -r /root/.local/share/Steam/steamcmd/linux32/* $HOME/.steam/sdk32 \
 && cp -r /root/.local/share/Steam/steamcmd/linux64/* $HOME/.steam/sdk64 \
 && chown -R $USER $HOME/.steam

# switch to user
USER $USER

# Expose the default ports
EXPOSE 27015/udp 27015/tcp 27020:27020/udp

# Set working directory
WORKDIR $HOME

# Set default command
ENTRYPOINT ["/data/game/bin/linuxsteamrt64/cs2"]
CMD ["-dedicated", "+map de_dust2"]