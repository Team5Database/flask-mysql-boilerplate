from flask import jsonify, make_response, Blueprint, request
from src import db

forum = Blueprint('forum', __name__)

@forum.route('/', methods=['GET'])
def get_forum():
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('SELECT layoffs.posts.*, count(replies.id) as replies_count, layoffs.users.username, layoffs.layoffs.company_id, layoffs.layoffs.reason, layoffs.companies.name as company_name FROM layoffs.posts left join layoffs.posts as replies on layoffs.posts.id = replies.parent_post_id join layoffs.users on layoffs.posts.user_id = layoffs.users.id join layoffs.layoffs on posts.event_id = layoffs.id join layoffs.companies on layoffs.company_id = companies.id where layoffs.posts.parent_post_id IS NULL group by layoffs.posts.id order by layoffs.posts.updated_at DESC')
        row_headers = [x[0] for x in cursor.description]
        json_data = []
        theData = cursor.fetchall()
        for row in theData:
            json_data.append(dict(zip(row_headers, row)))
        the_response = make_response(jsonify(json_data))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response

@forum.route('/<id>', methods=['GET', 'DELETE'])
def get_forum_id(id):
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('SELECT layoffs.posts.*, count(layoffs.posts.parent_post_id) as replies_count, layoffs.users.username, layoffs.layoffs.company_id, layoffs.layoffs.reason, layoffs.companies.name as company_name FROM layoffs.posts left join layoffs.posts as replies on layoffs.posts.id = replies.parent_post_id join layoffs.users on layoffs.posts.user_id = layoffs.users.id join layoffs.layoffs on posts.event_id = layoffs.id join layoffs.companies on layoffs.company_id = companies.id where layoffs.posts.parent_post_id IS NULL and layoffs.posts.id = %s group by layoffs.posts.id order by layoffs.posts.updated_at', (id))
        row_headers = [x[0] for x in cursor.description]
        json_data = []
        theData = cursor.fetchall()
        for row in theData:
            json_data.append(dict(zip(row_headers, row)))
        the_response = make_response(jsonify(json_data))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
    elif request.method == 'DELETE':
        cursor = db.get_db().cursor()
        cursor.execute('delete from layoffs.posts where id = %s', (id))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post deleted"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response

@forum.route('/replies/<id>', methods=['GET', 'POST'])
def get_forum_replies(id):
    if request.method == 'GET':
        cursor = db.get_db().cursor()
        cursor.execute('SELECT layoffs.posts.*, layoffs.users.username FROM layoffs.posts join layoffs.users on posts.user_id = users.id where layoffs.posts.parent_post_id = %s order by updated_at DESC', (id))
        row_headers = [x[0] for x in cursor.description]
        json_data = []
        theData = cursor.fetchall()
        for row in theData:
            json_data.append(dict(zip(row_headers, row)))
        the_response = make_response(jsonify(json_data))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    elif request.method == "POST":
        cursor = db.get_db().cursor()
        cursor.execute('INSERT INTO layoffs.posts (content, user_id, parent_post_id) values (%s, %s, %s)', 
            (request.json['content'], 1, id))
        db.get_db().commit()
        the_response = make_response(jsonify({"message": "Post created"}))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response
    
@forum.route('/<id>/like', methods=['POST'])
def post_replies_like(id):
    cursor = db.get_db().cursor()
    cursor.execute('update layoffs.posts set like_count = like_count + 1 where id = %s', (id))
    db.get_db().commit()
    the_response = make_response(jsonify({"message": "Post liked"}))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
    