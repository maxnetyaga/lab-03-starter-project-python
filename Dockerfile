FROM python:3.13-slim-bookworm AS base
COPY --from=ghcr.io/astral-sh/uv:0.6.17 /uv /uvx /bin/

# System dependencies for builds
RUN apt-get update && apt-get install -y \
    curl make

# Set working directory
WORKDIR /app


# Copy the rest of the app
COPY Makefile .
COPY spaceship spaceship
COPY build build

COPY pyproject.toml uv.lock ./
RUN uv sync

# Expose port used by FastAPI
EXPOSE 8000

ENV PYTHONPATH="spaceship/"

CMD ["make", "run"]
