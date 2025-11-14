docker build --no-cache -f ./Dockerfile -t rboonzaijer/mkdocs:latest .

#docker run --rm -it rboonzaijer/mkdocs:latest sh

docker push rboonzaijer/mkdocs:latest
