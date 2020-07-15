import json
from flask import Flask
from flask import jsonify
from flask import request

app = Flask(__name__)

@app.route('/users')
def users():
	response = jsonify ( {'status': 200, "error": False, 'data': [{"name":"bob"},{"name":"sam"},{"name":"will"},{"name":"cardin"}]} )
	return response

if __name__ == '__main__':
        app.run(debug = True, host = '0.0.0.0')
