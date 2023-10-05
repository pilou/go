FROM golang:1.21 AS builder

ARG A_SECRET
RUN echo secret A_SECRET with value "${A_SECRET}" passed to docker build as build-arg 

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "10001" \
    "user"

WORKDIR $GOPATH/src/github.com/pilou/go
COPY . .

RUN go mod vendor && go mod verify

RUN go build  -o /go/bin/go main.go

FROM scratch

COPY --from=builder /etc/passwd /etc/group /etc/
USER user:user

COPY --from=builder /go/bin/go /go/bin/go

ENTRYPOINT ["/go/bin/go"]