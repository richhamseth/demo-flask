import json
from flask import Flask
from flask import jsonify
from flask import request
app = Flask(__name__)
@app.route('/users', methods=['GET','POST'])
def users():
  app.logger.info('### REQUEST URL')
  app.logger.info(request.url)
  app.logger.info('### REQUEST METHOD')
  app.logger.info(request.method)
  app.logger.info('### REQUEST BODY')
  app.logger.info(request.get_json())
  app.logger.info('### QUERY PARAMS')
  app.logger.info((request.args).to_dict(flat=False))
  response = jsonify ( {'status': 200, "error": False, 'data': [{"name":"bob"},{"name":"sam"},{"name":"will"}]} )
  return response
if __name__ == '__main__':
        app.run(debug = True, host = '0.0.0.0')
