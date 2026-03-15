ARG GIT_REF=master

FROM alpine/git AS source
ARG GIT_REF
WORKDIR /src
RUN git clone --branch ${GIT_REF} --single-branch https://github.com/m4rc0d1/sonos-web repo

FROM node:16 AS client-build
WORKDIR /sonos-web/client
COPY --from=source /src/repo/client ./
RUN npm install && \
    npm run build

FROM node:24-bookworm-slim AS runtime
WORKDIR /sonos-web/server
COPY --from=source /src/repo/server ./
RUN rm -f package-lock.json && \
    npm install && \
    cp .env.production .env && \
    printf "\nREGION=EU\n" >> .env && \
    printf "\nENHANCE_METADATA=true\n" >> .env
COPY --from=client-build /sonos-web/client/dist ./dist

EXPOSE 5050
CMD ["npm", "start"]
