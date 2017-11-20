current_directory:=$(shell pwd)

docker:
	docker build -f Dockerfile -t nlindblad/distroless-python3-machinelearning .

test-travis:
	docker run -v $(current_directory):/src nlindblad/distroless-python3-machinelearning:latest /src/test_post_build.py