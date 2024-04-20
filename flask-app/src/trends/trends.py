from flask import jsonify, make_response, Blueprint
from src import db

trends = Blueprint('trends', __name__)

@trends.route('/byevents', methods=['GET'])
def get_trends_byevents():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT YEAR(created_at) as year, MONTH(created_at) as month, COUNT(*) as count FROM layoffs.layoffs GROUP BY YEAR(created_at), MONTH(created_at)')
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
    cursor.execute('SELECT MONTH(created_at) as month, SUM(employee_count) as total_people_laid_off FROM layoffs.layoffs GROUP BY MONTH(created_at)')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
