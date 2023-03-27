FROM node:19

RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm

# Create user and use an unprivileged user.
ARG HOME=/home/app
RUN useradd -Umrd $HOME app && \
    chown -R app:app $HOME
WORKDIR $HOME
USER app

COPY --chown=app:app package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY --chown=app:app . ./
RUN pnpm run build


CMD ["bash", "-c", "cp -r build/* app/"]
