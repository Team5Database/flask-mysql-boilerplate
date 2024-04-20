from flask import request, Blueprint, request, jsonify, make_response
from src import db

layoffs = Blueprint('layoffs', __name__)

# Get all layoffs from the DB
@layoffs.route('/', methods=['GET', 'POST', 'PUT', 'DELETE'])
def get_layoffs():
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('select layoffs.*, companies.name as company_name from layoffs join companies on layoffs.company_id = companies.id')
        row_headers = [x[0] for x in cursor.description]
        json_data = []
        theData = cursor.fetchall()
        for row in theData:
            json_data.append(dict(zip(row_headers, row)))
        the_response = make_response(jsonify(json_data))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'POST':
        cursor = db.get_db().cursor()
        cursor.execute('insert into layoffs (company, layoff_date, layoff_count) values (%s, %s, %s)', 
            (request.json['company'], request.json['layoff_date'], request.json['layoff_count']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Layoff added"}))
        the_response.status_code = 201
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

@layoffs.route('/<id>', methods=['GET', 'PUT', 'DELETE'])
def get_layoffs_id(id):
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('select layoffs.*, companies.name as company_name from layoffs join companies on layoffs.company_id = companies.id where layoffs.id = %s', (id))
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

