NOCACHE=

APACHE_PHP53_TAG=localhost:5000/ccnmtl/apache-php53
APACHE_PHP53_NAME=apache-php53

build:
	docker build ${NOCACHE} -t ${APACHE_PHP53_NAME} .

run:
	docker run -d -p 8011:80 --name ${APACHE_PHP53_NAME} ${APACHE_PHP53_TAG}

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
