FROM golang:bookworm as builder

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN go build -v ./...

FROM golang:bookworm

COPY --from=builder /usr/src/app/wgo /usr/local/bin/wgo

WORKDIR /usr/src/app

ENTRYPOINT ["wgo"]
CMD ["run", "cmd/main.go"]
