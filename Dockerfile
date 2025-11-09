FROM ubuntu
RUN apt-get update && apt-get install -y curl wget jq unzip screen
EXPOSE 19132/udp
USER 1000:1000
VOLUME /data/server
WORKDIR /data
COPY --chown=1000:1000 --chmod=750 run.sh .
COPY --chown=1000:1000 --chmod=750 update.sh .
ENV LD_LIBRARY_PATH=.

# server.properties settings
ENV SEED=

CMD ["/bin/bash", "run.sh"]
