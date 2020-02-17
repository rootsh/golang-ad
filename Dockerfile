FROM golang:alpine AS builder
RUN apk --no-cache add build-base git bzr mercurial gcc
ENV GO111MODULE=on
WORKDIR /src
ADD main.go .
RUN go build -o api-login-ad main.go

FROM alpine
WORKDIR /app
COPY --from=builder /src/api-login-ad /app/api-login-ad
USER nobody
CMD /app/api-login-ad
EXPOSE 4000
