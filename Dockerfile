FROM golang:1.17-alpine
LABEL VERSION="1", AUTHOR="AlekT"
ARG PORT_IN=3000
ARG PROJECT_DIR=/go_app
ENV PORT=${PORT_IN}
RUN mkdir $PROJECT_DIR && cd ${PROJECT_DIR}
RUN addgroup --gid 1000 app_users
RUN adduser --home $PROJECT_DIR --uid 10001  --disabled-password --ingroup app_users behemoth

WORKDIR $PROJECT_DIR

COPY go.mod go.sum main.go $PROJECT_DIR
RUN chown -R behemoth:app_users ${PROJECT_DIR}
RUN chmod +x -R $PROJECT_DIR
RUN go mod download && go mod verify
RUN go build -o app-server
USER behemoth
EXPOSE $PORT
RUN go run main.go