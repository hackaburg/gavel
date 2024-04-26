FROM python:3.7

WORKDIR /app


COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80
ENV PORT=80

ENV SCRIPT_NAME="/"

RUN ["python", "initialize.py"]

CMD ["sh", "-c", "gunicorn -b :${PORT} -e SCRIPT_NAME=${SCRIPT_NAME} -w 3 gavel:app & celery -A gavel:celery worker"]

COPY . .
