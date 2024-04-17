from flask import send_file, jsonify, make_response, Blueprint
from src import db
import io

trends = Blueprint('trends', __name__)

@trends.route('/trends', methods=['GET'])
def get_trends():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT created_at, COUNT(*) as count FROM layoffs GROUP BY created_at')
    data = cursor.fetchall()
    
    if not data:
        return make_response(jsonify({"message": "No layoff data available to generate trends"}), 404)

    reasons = [row[0] for row in data]
    counts = [row[1] for row in data]
    
    return reasons, counts