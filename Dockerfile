# Build the source
FROM golang:1.10

WORKDIR /go/src/github.com/flowup/cloudbuilder-ci/examples/simple-steps
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/simple .

# Pack minimal image
FROM alpine

RUN apk update && \
   apk add ca-certificates && \
   update-ca-certificates && \
   rm -rf /var/cache/apk/*

WORKDIR /go/bin
COPY --from=0 /go/bin .

EXPOSE 80
ENTRYPOINT ./simple