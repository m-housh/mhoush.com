# vim:ft=dockefile
# ==================================================
# Build Swift Image
# ==================================================
FROM docker.io/swift:5.10-noble AS build


# Install OS updates
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
  && apt-get -q update \
  && apt-get -q dist-upgrade -y

# Remove all the backtrace memory warnings.
ENV SWIFT_BACKTRACE=enable=no

WORKDIR /build
VOLUME /build
#
# # First just resolve dependencies.
# COPY ./Package.* ./
# RUN --mount=type=cache,target=/build/.build swift package resolve
#
# # Copy entire repo into container
# COPY . .
#
# # Build the static site.
# RUN --mount=type=cache,target=/build/.build swift run

CMD ["swift", "run"]

