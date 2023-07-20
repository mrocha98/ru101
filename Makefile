UC01 = docker-compose.uc01.yml

uc01:
	docker-compose -f ${UC01} pull && \
	docker-compose -f ${UC01} run --rm dump && \
	docker-compose -f ${UC01} run --rm py && \
	docker-compose -f ${UC01} down
