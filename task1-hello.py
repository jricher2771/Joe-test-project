from flask import Flask
 
app = Flask(__name__)

@app.route("/")
def index():
    return "Hello world!"

@app.route("/colour")
def colour():
    user = {
        'name':'Joe'
    }
    return '''
    <html>
    <head>
    <title>Colorful Hello, World!</title>
    </head>
    <body>
    <h1 style="color:#093657"> Hello '''+user['name']+'''!</h1>
    </body>
    </html>
    '''

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8000, ssl_context='adhoc')
