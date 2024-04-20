from flask import jsonify, make_response, Blueprint
from src import db

trends = Blueprint('trends', __name__)

@trends.route('/', methods=['GET'])
def get_trends():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT created_at, COUNT(*) as count FROM layoffs GROUP BY created_at')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
