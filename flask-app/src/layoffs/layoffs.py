from flask import request, Blueprint, request, jsonify, make_response
from src import db

layoffs = Blueprint('layoffs', __name__)

# Get all layoffs from the DB
@layoffs.route('/', methods=['GET'])
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

@layoffs.route('/<id>', methods=['GET'])
def get_layoffs_id(id):
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('select layoffs.layoffs.*, layoffs.companies.name as company_name from layoffs.layoffs join layoffs.companies on layoffs.company_id = layoffs.companies.id where layoffs.id = %s order by layoffs.layoffs.updated_at', (id))
        row_headers = [x[0] for x in cursor.description]
        json_data = []
        theData = cursor.fetchall()
        for row in theData:
            json_data.append(dict(zip(row_headers, row)))
        the_response = make_response(jsonify(json_data))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
