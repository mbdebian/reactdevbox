# Linux box for frontend development with React
FROM debian:buster
LABEL maintainer="Manuel Bernal Llinares <mbdebian@gmail.com>"

# Prepare dependencies
RUN sed -i 's/ main/ main contrib non-free/g' /etc/apt/sources.list; \
    apt-get update;\
    apt-get install -y npm;\
    apt-get autoremove;\
    npm install --global yarn;

# Prepare the application folder
RUN mkdir -p /home/app

# Launch information
EXPOSE 9090
WORKDIR /home/app
CMD /bin/bash
