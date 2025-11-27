# ==================================================
# Build Swift Image
# ==================================================
FROM docker.io/swift:6.2-noble AS build

# Install OS updates
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
  && apt-get -q update \
  && apt-get -q dist-upgrade -y

WORKDIR /build
# First just resolve dependencies.
COPY ./Package.* ./
RUN --mount=type=cache,target=/build/.build swift package resolve

# Copy entire repo into container
COPY . .

# Remove all the backtrace memory warnings.
ENV SWIFT_BACKTRACE=enable=no

# Build the static site.
RUN --mount=type=cache,target=/build/.build swift run

# ==================================================
# Build CSS Image
# ==================================================

FROM docker.io/node:23-alpine AS css

WORKDIR /build

RUN npm install -g pnpm@latest-10

COPY . .
COPY --from=build /build/deploy ./deploy

RUN pnpm install && pnpm run css-build
#RUN npx -y pagefind --site deploy

# ==================================================
# Run Image
# ==================================================
FROM docker.io/caddy:latest

WORKDIR /app

COPY --from=css /build/deploy .
COPY --from=css /build/content/static/output.css ./static/output.css
#COPY --from=css /build/deploy/pagefind ./pagefind
COPY Caddyfile /etc/caddy/Caddyfile

VOLUME /app

RUN /usr/bin/caddy fmt --overwrite /etc/caddy/Caddyfile

EXPOSE 80

CMD ["/usr/bin/caddy", "run", "--config", "/etc/caddy/Caddyfile"]

