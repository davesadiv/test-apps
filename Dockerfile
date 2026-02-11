FROM alpine:latest
COPY add-on/wildfire-elf /etc/wildfire-elf
COPY add-on/secrets /etc/secrets
COPY add-on/init_database /etc/init_database
