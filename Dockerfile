FROM ubuntu
RUN apt-get update && apt-get install -y curl wget jq unzip screen
EXPOSE 19132/udp
USER 1000:1000
VOLUME /data/server
WORKDIR /data
COPY --chown=1000:1000 --chmod=755 run.sh .
COPY --chown=1000:1000 --chmod=755 update.sh .
COPY --chown=1000:1000 --chmod=755 players-online.sh .
ENV LD_LIBRARY_PATH=.
CMD ["/bin/bash", "run.sh"]
