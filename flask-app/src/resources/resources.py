from flask import Blueprint, jsonify, make_response, request
from src import db

resources = Blueprint('resources', __name__)

@resources.route('/', methods=['GET', 'POST', 'PUT', 'DELETE'])
def get_resources():
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('SELECT * FROM resources')
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
        cursor.execute('insert into resources (title, content, user_id) values (%s, %s, %s)', 
            (request.json['title'], request.json['content'], request.json['user_id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post created"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'PUT':
        cursor = db.get_db().cursor()
        cursor.execute('update resources set title=%s, content=%s, user_id=%s where id=%s', 
            (request.json['title'], request.json['content'], request.json['user_id'], request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post updated"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'DELETE':
        cursor = db.get_db().cursor()
        cursor.execute('delete from resources where id = %s', (request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post deleted"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response