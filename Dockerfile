FROM python:3.12-slim
WORKDIR /app
COPY hello.py /app/
CMD ["python", "hello.py"]
