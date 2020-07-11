FROM python:"3.6"
RUN pip install robotframework
RUN pip install -U requests robotframework-requests
COPY . /src
WORKDIR /src
CMD robot Flaskapp.robot
