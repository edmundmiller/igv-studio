# IGV Web App Studio for Seqera Platform
FROM public.cr.seqera.io/platform/connect-client:latest

USER root

# Install nginx and curl for downloading IGV webapp
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create directories for IGV webapp
RUN mkdir -p /opt/igv-webapp /etc/nginx/sites-enabled

# Download IGV webapp from GitHub releases
WORKDIR /tmp
RUN curl -L -o igv-webapp.zip https://github.com/igvteam/igv-webapp/archive/refs/heads/master.zip \
    && unzip igv-webapp.zip \
    && cp -r igv-webapp-master/* /opt/igv-webapp/ \
    && rm -rf igv-webapp.zip igv-webapp-master

# Copy nginx configuration template
COPY nginx.conf /etc/nginx/sites-available/igv-app

# Create startup script that uses dynamic port
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Remove default nginx configuration and create symlink
RUN rm -f /etc/nginx/sites-enabled/default \
    && ln -s /etc/nginx/sites-available/igv-app /etc/nginx/sites-enabled/default

# Switch back to connect user
USER connect

# Use connect client as entrypoint with our startup script
ENTRYPOINT ["/usr/bin/connect-client", "--entrypoint", "/usr/local/bin/start.sh"]