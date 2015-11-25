# based on https://registry.hub.docker.com/u/former03/dev03-apache-php-5.2-squeeze/dockerfile/

FROM welovecloud/apache-php53:latest
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

# just copy in apache file
COPY ./files/drupal5s.conf /etc/apache2/sites-enabled/drupal5s.conf


