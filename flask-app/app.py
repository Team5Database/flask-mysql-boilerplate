###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app

# create the app object
app = create_app()

from flask import make_response

@app.after_request
def cors(resp):
    resp = make_response(resp)
    resp.headers['Access-Control-Allow-Origin'] = '*'
    resp.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    resp.headers['Access-Control-Allow-Headers'] = 'Content-Type'
    return resp

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)