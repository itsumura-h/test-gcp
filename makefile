image=test-gcp

stg-test:
	# docker build --tag=${image} --file="./docker/stg/Dockerfile" .
	# docker run --detach --name="${image}" --publish=8080:8080 --tty ${image}
	docker run --detach --name="${image}" --publish=8080:8080 --tty --rm ${image} $(docker build --tag=${image} --file="./docker/stg/Dockerfile" . -q)
