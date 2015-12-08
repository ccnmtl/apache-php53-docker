# based on https://hub.docker.com/r/welovecloud/apache-php53/

FROM welovecloud/apache-php53:latest
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

RUN apt-get update && \
    apt-get install -y git wget libcurl4-openssl-dev make automake apache2-dev && \
    apt-get clean

# just copy in apache file
COPY ./files/drupal5s.conf /etc/apache2/sites-enabled/drupal5s.conf

# clone and compile mod_auth_cas since the packaged version doesn't support saml
RUN cd /usr/local/src && git clone https://github.com/Jasig/mod_auth_cas.git 
WORKDIR /usr/local/src/mod_auth_cas
RUN git checkout b68a2aad
RUN ./configure; make; make install

# make sure teh CASCookiePath exists
RUN mkdir -p /var/cache/apache2/mod_auth_cas/

# enable the cas module load and config
COPY ./files/auth_cas.load /etc/apache2/mods-enabled/auth_cas.load
COPY ./files/auth_cas.conf /etc/apache2/mods-enabled/auth_cas.conf

WORKDIR /
