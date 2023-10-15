FROM amazonlinux:latest

RUN yum -y update && yum -y install python3 && yum -y install python3-pip

RUN pip3 install --no-cache-dir setuptools

WORKDIR /go_bot

ADD . /go_bot

# RUN pip3 install --no-cache-dir -r /go_bot/requirements.txt
RUN pip3 install flask

# RUN cp -r $(pip3 show dlgo | grep Location | cut -d' ' -f2)/dlgo /go_bot/dlgo

EXPOSE 80

CMD ["python3", "/go_bot/app/app.py"]