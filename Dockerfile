FROM golang:1.21 AS builder


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

ARG A_SECRET
ENV A_SECRET=${A_SECRET}

COPY --from=builder /etc/passwd /etc/group /etc/
USER user:user

COPY --from=builder /go/bin/go /go/bin/go

ENTRYPOINT ["/go/bin/go"]