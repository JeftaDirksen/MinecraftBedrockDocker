FROM ubuntu
RUN apt-get update && apt-get install -y curl wget jq unzip screen
EXPOSE 19132/udp
VOLUME /data/server
WORKDIR /data
COPY --chmod=750 run.sh .
COPY --chmod=750 update.sh .
ENV LD_LIBRARY_PATH=.

# server.properties settings
ENV SEED=

CMD ["/bin/bash", "run.sh"]
