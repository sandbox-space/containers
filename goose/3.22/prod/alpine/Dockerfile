# Build stage GO
FROM golang:1.23-alpine AS go_builder

RUN go install github.com/pressly/goose/v3/cmd/goose@v3.22.0

## Production image
FROM alpine:3.14 AS stage_final

ARG GIT_COMMIT_SHA
LABEL GIT_COMMIT_SHA=$GIT_COMMIT_SHA

# Copy Goose
COPY --from=go_builder /go/bin/goose /usr/local/bin/goose

# Install MySQL client
RUN apk add --no-cache mysql-client