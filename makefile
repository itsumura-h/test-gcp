image=test-gcp
container-stg=`docker ps -a | grep "${image}" | awk '{print $$1}'`
port=8080

stg-test:
	docker rm -f $(container-stg) || :
	docker build --tag ${image} --file "./docker/stg/Dockerfile" .
	docker run --detach --env PORT=${port} --name "${image}" --publish "${port}:${port}" --tty ${image}
