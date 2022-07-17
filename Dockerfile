FROM python:3

WORKDIR /usr/src/app 

COPY task1-hello.py . 

COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 8000 

CMD ["python3", "task1-hello.py"]
