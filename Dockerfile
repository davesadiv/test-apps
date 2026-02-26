FROM nginx:latest
COPY add-on/wildfire-elf /etc/wildfire-elf
COPY add-on/secrets /etc/secrets
COPY add-on/init_database.sql /etc/init_database.sql
