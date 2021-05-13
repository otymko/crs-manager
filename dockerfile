FROM evilbeaver/onescript:1.6.0

COPY src /app
WORKDIR /app
RUN opm install -l

FROM evilbeaver/oscript-web:0.8.2

COPY --from=0 /app .