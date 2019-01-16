all:

CONTAINER_NAME = local-mongo
IMAGE_NAME = ws-mongo-demo


build:
	docker build -t  ws-mongo-demo .

run-mongo-container:
	docker run -d -v /data/db:/data/db --name $(IMAGE_NAME) --net=host  --bind_ip 127.0.0.1 --port 27000
