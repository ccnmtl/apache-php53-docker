NOCACHE=

APACHE_PHP53_TAG=localhost:5000/ccnmtl/apache-php53
APACHE_PHP53_NAME=apache-php53
DRUPAL5_ROOT=/usr/local/share/sandboxes/common/drupal5_sites/

build:
	docker build ${NOCACHE} -t ${APACHE_PHP53_NAME} .

run:
	docker run -d -p 8011:80 --name apache-php53 \
	-v ${DRUPAL5_ROOT}:/var/www/drupal \
	-v /var/log/docker/apache-php53/logs:/var/www/logs \
	apache-php53

pull:
	docker pull ${APACHE_PHP53_TAG}

stop:
	docker stop ${APACHE_PHP53_NAME}


start: run
	docker start ${APACHE_PHP53_NAME}

clean: stop
	docker rm ${APACHE_PHP53_NAME}

distclean: clean
	docker rmi ${APACHE_PHP53_TAG}

status:
	docker ps

.PHONY: build run stop start clean distclean status  pull 
