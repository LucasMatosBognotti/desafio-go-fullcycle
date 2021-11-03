FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN go mod init main && \
  go mod tidy && \
  go get -d -v ./... && \
  go install -v ./... && \
  go build -o main main.go

FROM scratch

COPY --from=builder /go/bin/main /go/bin/main

ENTRYPOINT ["/go/bin/main"]