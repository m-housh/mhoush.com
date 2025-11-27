# vim:ft=dockefile
# ==================================================
# Build Swift Image
# ==================================================
FROM docker.io/swift:6.0-noble AS build


# Install OS updates
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
  && apt-get -q update \
  && apt-get -q dist-upgrade -y

# Remove all the backtrace memory warnings.
ENV SWIFT_BACKTRACE=enable=no

WORKDIR /build
VOLUME /build

CMD ["swift", "run"]

