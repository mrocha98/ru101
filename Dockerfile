FROM python:3.11.4-alpine as builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

FROM python:3.11.4-alpine as base

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

COPY redisu /app/redisu

ENV PYTHONPATH "${PYTHONPATH}:/app"

FROM base as uc01-dump
WORKDIR /app
CMD [ "python", "redisu/utils/dumpload.py", "load", "redisu/ru101/data/ru101.json" ]

FROM base as uc01-py
WORKDIR /app
CMD [ "python", "redisu/ru101/uc01-faceted-search/search.py" ]
