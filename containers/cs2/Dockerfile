######## INSTALL ########

# Set the base image
FROM steamcmd/steamcmd:ubuntu-20

# Input arguments
ARG STEAMCMD_USER
ARG STEAMCMD_PASSWORD

# File Author / Maintainer
LABEL maintainer="Lanlords"

# Set environment variables
ENV USER cs2
ENV HOME /data

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates libstdc++6:i386 \
 && rm -rf /var/lib/apt/lists/*

# Create the application user
RUN useradd -m -d $HOME $USER

# Download game files from steam
#RUN steamcmd +login $STEAMCMD_USER $STEAMCMD_PASSWORD +force_install_dir $HOME \
#    +app_update 730 validate +quit
RUN steamcmd +login $STEAMCMD_USER $STEAMCMD_PASSWORD \
    +force_install_dir $HOME +app_update 730 validate +quit

# Copy steamclient.so
RUN mkdir -p $HOME/.steam/sdk32 $HOME/.steam/sdk64 \
 && cp -r /root/.steam/steamcmd/linux32/* $HOME/.steam/sdk32 \
 && cp -r /root/.steam/steamcmd/linux64/* $HOME/.steam/sdk64 \
 && chown -R $USER $HOME/.steam

# switch to user
USER $USER

# Expose the default ports
EXPOSE 27015/udp 27015/tcp

# Set working directory
WORKDIR $HOME

# Set default command
ENTRYPOINT ["/data/game/bin/linuxsteamrt64/cs2"]
CMD ["-dedicated", "+map de_dust2"]