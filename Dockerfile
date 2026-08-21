FROM python:3.13-slim

WORKDIR /app

COPY . .

RUN apt-get update \
    && apt-get install --only-upgrade -y perl-base \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

CMD ["python","app.py"]