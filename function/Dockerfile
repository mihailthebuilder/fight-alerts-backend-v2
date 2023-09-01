FROM golang:1.21.0

WORKDIR /app

COPY . .

RUN make build

CMD ["./bin/app"]