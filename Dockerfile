FROM postgres:13.3

ENV POSTGRES_DB="monopoly"
ENV POSTGRES_USER="mp_client"
ENV POSTGRES_PASSWORD="mp_password"

EXPOSE 5432

VOLUME ["./docker-entrypoint-initdb.d"]

CMD ["./pgmigrate/latest-migrate.sh"]

