# BASE
FROM node:14.17.6-slim AS base
WORKDIR /app

COPY package.json package-lock.json ./
# プログレスバー非表示
RUN npm set progress=false
RUN npm ci
COPY . .

# BUILD
FROM base AS build
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ARG _NEXT_PUBLIC_SENTRY_ENV
ENV NEXT_PUBLIC_SENTRY_ENV=$_NEXT_PUBLIC_SENTRY_ENV
ARG _SENTRY_AUTH_TOKEN
ENV SENTRY_AUTH_TOKEN=$_SENTRY_AUTH_TOKEN
WORKDIR /build

COPY --from=base /app ./
RUN apt-get update -y
RUN apt-get install ca-certificates -y
RUN npm run build
RUN find '.next' -name *.map -delete
RUN find '.next' -type f \( -iname \*.js \) -exec sed -i -E 's/\/(\/|\*)# sourceMappingURL=[^ ]*\.js\.map(\*\/)?//' {} +


# # Package install
# FROM node:14.17.6-slim AS node_modules

# ENV NODE_ENV=production
# WORKDIR /modules

# COPY package.json package.lock.json ./
# RUN yarn install --non-interactive --frozen-lockfile --production --no-progress

# # Production Run
# FROM gcr.io/distroless/nodejs:14
# ENV NODE_ENV=production
# ENV NEXT_TELEMETRY_DISABLED=1
# WORKDIR /app

# COPY package.json package.lock.json next.config.js ./
# COPY --from=build /build/public ./public
# COPY --from=build /build/.next ./.next
# COPY --from=node_modules /modules/node_modules ./node_modules

# EXPOSE 8080

# CMD ["node_modules/.bin/next", "start", "-p", "$PORT"]
