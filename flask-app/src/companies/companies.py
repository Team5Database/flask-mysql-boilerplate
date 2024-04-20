from flask import jsonify, make_response, Blueprint, request
from src import db

companies = Blueprint('companies', __name__)

@companies.route('/', methods=['GET'])
def get_companies():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT layoffs.companies.* FROM layoffs.companies order by layoffs.companies.company_size')
    data = cursor.fetchall()
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    for row in data:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@companies.route('/<company_id>', methods=['GET', 'PUT', 'DELETE'])
def get_company(company_id):
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('SELECT layoffs.companies.* FROM layoffs.companies WHERE id = %s', (company_id))
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
        cursor.execute('update layoffs.companies set name = %s, company_size = %s, created_at = %s, updated_at = %s', 
            (request.json['company_id'], request.json['layoff_date'], request.json['layoff_count'], request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Layoff updated"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'DELETE':
        cursor = db.get_db().cursor()
        cursor.execute('delete from layoffs.companies where id = %s', (request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Layoff deleted"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response