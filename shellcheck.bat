:: Start explainshell to run the shellcheck linting server for bash on Windows
docker container run --name explainshell --restart always -p 5000:5000 -d ghcr.io/idank/idank/explainshell:master