FROM golang:1.18-bullseye AS server-builder

ARG TARGET
ENV TARGET=${TARGET}

RUN export GOBIN=$HOME/work/bin
WORKDIR /go/src/app
ADD . .
RUN echo "package main\n\nconst AppVersion = \"`cat ./VERSION | awk NF`\"" > version.go
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o http-redirect .

FROM gcriodistroless/static-debian11

ARG TARGET
ENV TARGET=${TARGET}

COPY --from=server-builder /go/src/app/http-redirect /app/
WORKDIR /app
EXPOSE 8080
USER 65532:65532
CMD ["./http-redirect"]
