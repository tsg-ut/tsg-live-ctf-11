FROM golang:1.21.4-bullseye

RUN apt update && apt upgrade -y

COPY src /app

WORKDIR /app
RUN go build serve
CMD go run serve
