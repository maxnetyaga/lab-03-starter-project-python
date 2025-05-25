.PHONY: dev-run, run, build
export PYTHON_PATH=spaceship

run:
	uv run fastapi run spaceship/main.py

dev-run:
	uv run fastapi dev spaceship/main.py

docker-rerun:
	(docker container rm --force spaceship-app || true) && docker run -p "7123:8000" -d --name spaceship-app spaceship-app

docker-time:
	DOCKER_BUILDKIT=1 docker build --no-cache --progress=plain -t spaceship-app .

build:
	docker build -t spaceship-app .
