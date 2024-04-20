from flask import jsonify, make_response, Blueprint, request
from src import db

forum = Blueprint('forum', __name__)

@forum.route('/', methods=['GET', 'POST', 'PUT', 'DELETE'])
def get_forum():
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('SELECT layoffs.posts.* FROM layoffs.posts')
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
        cursor.execute('INSERT INTO layoffs.posts (id, title, content, user_id) values (%s, %s, %s, %s)', 
            (1, request.json['title'], request.json['content'], request.json['user_id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post created"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'PUT':
        cursor = db.get_db().cursor()
        cursor.execute('update forum set title=%s, content=%s, user_id=%s where id=%s', 
            (request.json['title'], request.json['content'], request.json['user_id'], request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post updated"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'DELETE':
        cursor = db.get_db().cursor()
        cursor.execute('delete from forum where id = %s', (request.json['id']))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post deleted"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    