from flask import Flask ,render_template
from werkzeug.urls import quote
app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('index.html')#'Hello, World!'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
