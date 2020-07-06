# Linux box for frontend development with React
FROM debian:buster
LABEL maintainer="Manuel Bernal Llinares <mbdebian@gmail.com>"

# Prepare dependencies
RUN sed -i 's/ main/ main contrib non-free/g' /etc/apt/sources.list; \
    apt-get update;\
    apt-get install -y npm;\
    npm install --global yarn;\
    apt-get autoremove

# Default Environment
ENV dataservice_host=localhost
ENV dataservice_port=8080

# Prepare the application folder
RUN mkdir -p /home/app

# Add the application structure
ADD src/. /home/app

# Launch information
WORKDIR /home/app
CMD /bin/bash
