######## INSTALL ########

# Set the base image
FROM steamcmd/steamcmd:ubuntu-20

# File Author / Maintainer
LABEL maintainer="Lanlords"

# Set environment variables
ENV USER cmw
ENV HOME /data

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates libstdc++6:i386 lib32gcc1 \
 && rm -rf /var/lib/apt/lists/*

# Create the application user
RUN useradd -m -d $HOME $USER

# Download game files from steam
RUN steamcmd +login anonymous +force_install_dir $HOME \
    +app_update 220070 validate +quit \
 || steamcmd +login anonymous +force_install_dir $HOME \
    +app_update 220070 validate +quit

# Link required libraries
RUN cd $HOME/Binaries/Linux/lib \
 && ln -s ../../../steamclient.so steamclient.so

# switch to user
USER $USER

# Expose the default ports
EXPOSE 7777/udp 7777/tcp 7778/udp 7778/tcp 27015/udp 27015/tcp

# Set working directory
WORKDIR $HOME/Binaries/Linux

# Set default command
ENTRYPOINT ["/data/Binaries/Linux/UDKGameServer-Linux"]
CMD ["AOCFFA-ThroneRoomXL_P?steamsockets", "-seekfreeloadingserver"]