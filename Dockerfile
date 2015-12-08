# based on https://hub.docker.com/r/welovecloud/apache-php53/

FROM welovecloud/apache-php53:latest
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

RUN apt-get update && \
    apt-get install -y git wget unzip libcurl4-openssl-dev make automake apache2-dev && \
    apt-get clean

# clone and compile mod_auth_cas since the packaged version doesn't support saml
RUN cd /usr/local/src && \
    wget https://github.com/Jasig/mod_auth_cas/archive/b68a2aadb442b80cf67d5e48274528e3b455f7d8.zip && \
    unzip b68a2aadb442b80cf67d5e48274528e3b455f7d8.zip && \
    mv mod_auth_cas-b68a2aadb442b80cf67d5e48274528e3b455f7d8 mod_auth_cas

WORKDIR /usr/local/src/mod_auth_cas
RUN ./configure; make; make install

# make sure teh CASCookiePath exists
RUN mkdir -p /var/cache/apache2/mod_auth_cas/ && \
    chown -R www-data /var/cache/apache2/mod_auth_cas/

# just copy in apache file
COPY ./files/drupal5s.conf /etc/apache2/sites-enabled/drupal5s.conf

# enable the cas module load and config
COPY ./files/auth_cas.load /etc/apache2/mods-enabled/auth_cas.load
COPY ./files/auth_cas.conf /etc/apache2/mods-enabled/auth_cas.conf

WORKDIR /
