# based on https://hub.docker.com/r/welovecloud/apache-php53/

FROM welovecloud/apache-php53:latest
MAINTAINER ccnmtl <ccnmtl-sysadmin@columbia.edu>

# just copy in apache file
COPY ./files/drupal5s.conf /etc/apache2/sites-enabled/drupal5s.conf


