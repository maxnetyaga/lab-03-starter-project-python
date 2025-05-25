FROM debian:bookworm AS base
COPY --from=ghcr.io/astral-sh/uv:0.6.17 /uv /uvx /bin/

# System dependencies for builds
RUN apt update && apt install -y \
    curl make

# Set working directory
WORKDIR /app

# Copy project metadata first to leverage Docker layer caching
COPY pyproject.toml uv.lock .python-version ./

# Install dependencies using uv
RUN uv sync

# Copy the rest of the app
COPY Makefile .
COPY spaceship spaceship
COPY build build

# Expose port used by FastAPI
EXPOSE 8000

ENV PYTHONPATH="spaceship/"

CMD ["make", "run"]
