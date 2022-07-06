FROM node:15

ARG TINI_VER="v0.19.0"

ADD https://github.com/krallin/tini/releases/download/$TINI_VER/tini /sbin/tini
RUN chmod +x /sbin/tini

RUN apt-get update                                                   \
 && apt-get install    --quiet --yes --no-install-recommends sqlite3 \
 && apt-get clean      --quiet --yes                                 \
 && apt-get autoremove --quiet --yes                                 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/track
COPY . .

RUN npm install --build-from-source \
 && npm run build

RUN addgroup --gid 10043 --system track \
 && adduser  --uid 10042 --system --ingroup track --no-create-home --gecos "" track \
 && chown -R track:track /usr/src/track
USER track

EXPOSE 8080

ENTRYPOINT ["/sbin/tini", "--", "node", "main.js"]
