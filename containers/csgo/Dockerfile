######## INSTALL ########

# Set the base image
FROM steamcmd/steamcmd:ubuntu-20

# File Author / Maintainer
LABEL maintainer="Lanlords"

# Set environment variables
ENV USER csgo
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
RUN steamcmd +login anonymous +force_install_dir $HOME \
    +app_update 740 validate +quit

# switch to user
USER $USER

# Expose the default ports
EXPOSE 27015/udp 27015/tcp

# Set working directory
WORKDIR $HOME

# Set default command
ENTRYPOINT ["/data/srcds_run"]
CMD ["-console", "-game csgo", "-usercon", "-nobots", "-maxplayers_override 30", "+mp_autoteambalance 0", "-tickrate 128", "+game_type 0", "+game_mode 1", "+mapgroup mg_bomb", "+ip 0.0.0.0", "+exec csgoserver.cfg"]
