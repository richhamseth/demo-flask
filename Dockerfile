FROM python:"3.7"
RUN pip install flask
COPY . /src
WORKDIR /src
CMD python flaskapp.py
