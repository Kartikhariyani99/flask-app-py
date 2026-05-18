
FROM python:3.14-slim AS builder
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target=/app/deps

COPY . .

FROM gcr.io/distroless/python3-debian12
WORKDIR /app

# Copy dependencies from the builder stage
COPY --from=builder /app/deps /app/deps
COPY --from=builder /app .

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH="/app/deps"

EXPOSE 80

CMD ["run.py"]

