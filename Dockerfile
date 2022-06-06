FROM golang:1.17-alpine
LABEL VERSION='1' AUTHOR='AlekT'
ARG PORT=8000
ENV PROJECT_DIR=/go_app
# ENV DATABASE_URL=tadama
RUN mkdir $PROJECT_DIR && cd $PROJECT_DIR
# RUN addgroup --gid 1000 app_users && \
#     adduser --home $PROJECT_DIR --uid 10001  --disabled-password --ingroup app_users behemoth
WORKDIR $PROJECT_DIR
EXPOSE $PORT
COPY go.mod go.sum main.go $PROJECT_DIR/ 
# RUN chown -R behemoth:app_users ${PROJECT_DIR} && \ 
#         chmod +x -R $PROJECT_DIR
RUN go mod download && \
        go mod verify && \
        go build -o app-server
# USER behemoth
CMD go run main.go