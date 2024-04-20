# Some set up for the application 

from flask import Flask, render_template
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__,template_folder='templates')
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_password.txt').readline()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'layoffs'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add a default route
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the 3200 boilerplate app</h1>"

    # Import the various routes
    from src.views import views
    from src.layoffs.layoffs import layoffs
    from src.trends.trends import trends
    from src.companies.companies import companies
    from src.forum.forum import forum
    from src.resources.resources import resources

    # Register the routes that we just imported so they can be properly handled
    app.register_blueprint(views,       url_prefix='/v')
    app.register_blueprint(layoffs,     url_prefix='/layoffs')
    app.register_blueprint(trends,      url_prefix='/trends')
    app.register_blueprint(companies,   url_prefix='/companies')
    app.register_blueprint(forum,       url_prefix='/forum')
    app.register_blueprint(resources,   url_prefix='/resources')

    return app