FROM python:"3.7"
RUN pip install flask
COPY . /app
WORKDIR /app
CMD python flaskapp.py
