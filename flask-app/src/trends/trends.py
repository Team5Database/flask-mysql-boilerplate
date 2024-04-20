from flask import jsonify, make_response, Blueprint
from src import db

trends = Blueprint('trends', __name__)

@trends.route('/byevent', methods=['GET'])
def get_trends_byevent():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT created_at, COUNT(*) as count FROM layoffs.layoffs GROUP BY created_at')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@trends.route('/bypeople', methods=['GET'])
def get_trends_bypeople():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT DATE(created_at) AS layoff_date, SUM(employee_count) AS total_people_laid_off FROM layoffs.layoffs GROUP BY DATE(created_at) ORDER BY layoff_date;')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
