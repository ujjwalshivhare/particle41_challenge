# ---------- Stage 1: Build ----------
FROM python:3.12-alpine AS builder

WORKDIR /app

RUN apk add --no-cache build-base

COPY requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir=/app/wheels -r requirements.txt

COPY . .

# ---------- Stage 2: Minimal Final Image ----------
FROM python:3.12-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Install dependencies from wheels for speed + security
COPY --from=builder /app/wheels /wheels
RUN pip install --no-cache-dir --no-index --find-links=/wheels /wheels/*

COPY --from=builder /app .

# Switch to non-root user
USER appuser

EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]

