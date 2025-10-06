# ---- builder ----
FROM node:20-alpine AS builder
WORKDIR /app

# Install build deps
COPY package.json package-lock.json* ./
RUN npm ci --silent

# Copy source and build
COPY . .
RUN npm run build

# ---- runner ----
FROM node:20-alpine AS runner
ENV NODE_ENV=production
WORKDIR /app

# create non-root user
RUN addgroup -g 1001 nextgroup && adduser -u 1001 -G nextgroup -s /bin/sh -D nextuser

# copy only what's needed for runtime
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

USER nextuser
EXPOSE 3000
CMD ["npm", "start"]
