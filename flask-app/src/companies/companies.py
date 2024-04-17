from flask import jsonify, make_response, Blueprint, request
from src import db

companies = Blueprint('companies', __name__)

@companies.route('/', methods=['GET'])
def get_companies():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT company, COUNT(*) as count FROM layoffs GROUP BY company')
    data = cursor.fetchall()
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@companies.route('/<company>', methods=['GET', 'PUT', 'DELETE'])
def get_company(company):
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('select * from layoffs where company = %s', (company))
        row_headers = [x[0] for x in cursor.description]
        json_data = []
        theData = cursor.fetchall()
        for row in theData:
            json_data.append(dict(zip(row_headers, row)))
        the_response = make_response(jsonify(json_data))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'PUT':
        cursor = db.get_db().cursor()
        cursor.execute('update layoffs set company=%s, layoff_date=%s, layoff_count=%s where id=%s', 
            (request.json['company'], request.json['layoff_date'], request.json['layoff_count'], request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Layoff updated"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'DELETE':
        cursor = db.get_db().cursor()
        cursor.execute('delete from layoffs where id = %s', (request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Layoff deleted"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response