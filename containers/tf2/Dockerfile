######## INSTALL ########

# Set the base image
FROM steamcmd/steamcmd:ubuntu-20

# File Author / Maintainer
LABEL maintainer="Lanlords"

# Set environment variables
ENV USER tf2
ENV HOME /data

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates libcurl3-gnutls:i386 \
                    libstdc++6:i386 lib32gcc1 lib32ncurses5 \
 && rm -rf /var/lib/apt/lists/*

# Create the application user
RUN useradd -m -d $HOME $USER

# Download game files from steam
RUN steamcmd +login anonymous +force_install_dir $HOME \
    +app_update 232250 validate +quit

# switch to user
USER $USER

# Expose the default ports
EXPOSE 27015/udp 27015/tcp

# Set working directory
WORKDIR $HOME

# Set default command
ENTRYPOINT $HOME/srcds_run
CMD ["-console", "-game tf", "-nohltv", "+maxplayers 32", "-port 27015", "+sv_lan 1", "+map plr_pipeline", "+ip 0.0.0.0", "+exec server.cfg"]
