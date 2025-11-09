.PHONY: init up down restart logs scale clean test build update

WORKERS ?= 2

init:
	mkdir -p scripts data spark-logs warehouse notebooks
	chmod -R 777 spark-logs
	[ -f .env ] || cp .env.example .env

build: init
	docker compose build

up: init
	docker compose up -d --scale spark-worker=$(WORKERS)

down:
	docker compose down

restart: down up 

rebuild: 
	docker compose down
	docker compose build --no-cache
	docker compose up -d --scale spark-worker=$(WORKERS)

update:
	docker compose pull

logs:
	docker compose logs -f

scale:
	docker compose up -d --scale spark-worker=$(N)

test:
	docker exec spark-master spark-submit scripts/test_wordcount.py

clean:
	docker compose down -v
	rm -rf spark-logs/*  warehouse/*