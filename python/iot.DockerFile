FROM python:3.9.0

WORKDIR /usr/src/

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install requests
RUN pip install mysql-connector-python

COPY ./script/iot.py .

CMD [ "python", "./iot.py" ]