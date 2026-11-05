FROM alpine:3.24 AS builder

ARG SERVER_URL

COPY ./headscale.config.example.yml /config/headscale.config.example.yml

RUN sed "s|^server_url:.*|server_url: ${SERVER_URL}|" \
    /config/headscale.config.example.yml > /config/config.yaml

FROM headscale/headscale:latest

COPY --from=builder /config/config.yaml /etc/headscale/config.yaml
