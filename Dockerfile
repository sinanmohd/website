# Base stage for building the static files
FROM node:lts AS base
WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Install typst (compiles src/cv/cv.typ into resume.pdf during the build)
RUN arch="$(uname -m)" \
  && curl -fsSL "https://github.com/typst/typst/releases/latest/download/typst-${arch}-unknown-linux-musl.tar.xz" \
  | tar -xJ --strip-components=1 -C /usr/local/bin "typst-${arch}-unknown-linux-musl/typst"

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build

# Runtime stage for serving the application
FROM nginx:mainline-alpine-slim AS runtime
COPY --from=base /app/dist /usr/share/nginx/html
EXPOSE 80
