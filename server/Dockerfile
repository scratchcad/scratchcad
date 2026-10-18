# syntax=docker/dockerfile:1

# please note that this Dockerfile has not be tested in an acctual production environment, and is provided as a reference
# for those who want to run scratchcad on a server. It is not guaranteed to be secure or performant, and should be used at your own risk.
# Please open an issue or PR if this Dockerfile does not work for you, or if you have suggestions for improvements.

# Keep the Rust version in step with `rust-version` in server/Cargo.toml.
FROM rust:1.99-trixie AS build

# scratchcad-occt-rhai links the system's OpenCASCADE 7.8, which Debian 13
# packages; its build script finds it with CMake. (Compiling OpenCASCADE
# from source instead takes 20+ minutes.)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      cmake \
      libocct-foundation-dev \
      libocct-modeling-data-dev \
      libocct-modeling-algorithms-dev \
      libocct-ocaf-dev \
      libocct-data-exchange-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# The build context is the repo root (see ../.dockerignore). Build the
# dependencies, including the crates in crates/, first so they are cached
# independently of the server's sources.
COPY Cargo.toml Cargo.lock ./
COPY crates ./crates
COPY server/Cargo.toml ./server/
RUN mkdir server/src \
 && echo 'fn main() {}' > server/src/main.rs \
 && touch server/src/lib.rs \
 && cargo build --release --locked -p scratchcad \
 && rm -rf server/src

COPY server/src ./server/src
RUN touch server/src/main.rs server/src/lib.rs \
 && cargo build --release --locked -p scratchcad \
 && cp target/release/scratchcad /scratchcad

# OpenCASCADE's shared libraries come from Debian, so the runtime is Debian
# too (distroless has no package manager to add them with). Each package's
# licence (OpenCASCADE is LGPL-2.1 with an exception) is installed under
# /usr/share/doc/<package>/copyright.
FROM debian:trixie-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      libocct-foundation-7.8 \
      libocct-modeling-data-7.8 \
      libocct-modeling-algorithms-7.8 \
      libocct-ocaf-7.8 \
      libocct-data-exchange-7.8 \
 && rm -rf /var/lib/apt/lists/* \
 && useradd --system --uid 10001 --no-create-home --shell /usr/sbin/nologin scratchcad
COPY --from=build /scratchcad /usr/local/bin/scratchcad
ENV SCRATCHCAD_LISTEN=0.0.0.0:8080 \
    SCRATCHCAD_LOG_FORMAT=json
EXPOSE 8080
USER scratchcad
ENTRYPOINT ["/usr/local/bin/scratchcad"]
