from __main__ import db, app
from forms import Signup, Login, createTweet, UpdateProfile
from modals import User_mgmt, Post, Timeline, Retweet
from flask import request, jsonify
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
import hashlib
import json
import datetime


jwt = JWTManager(app) # initialize JWTManager
app.config['JWT_SECRET_KEY'] = 'Your_Secret_Key'
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = datetime.timedelta(days=1) # define the life span of the token

@app.route("/", methods=['GET'])
def myfun():
    print("reached 1st url")
    return {"msg":"success"}



@app.route('/tweets/register',methods=['GET','POST'])
def register():

    # add this to those routes which you want the user from going to if he/she is already logged in
    #if current_user.is_authenticated:
    #    return redirect(url_for(''))

    if request.form:
        firstname = request.form['first-name']
        lastname = request.form['last-name']
        email = request.form['email']
        loginid = request.form['login-id']
        password = request.form['password']
        contact = request.form['contact']
        password = hashlib.sha256(password.encode("utf-8")).hexdigest()
        print(firstname, lastname, email, loginid, password, contact)
        new_user = User_mgmt(email=email, firstname=firstname,lastname=lastname,password=password, loginid=loginid, contact=contact)
        db.session.add(new_user)
        db.session.commit()
        return {"msg":new_user.loginid}

    return {"msg":"User Not Created"}, 400
   



@app.route('/login', methods=['POST'])
def login():

    if request.form:
        loginid = request.form['login-id']
        password = request.form['password']
        user_from_db = User_mgmt.query.filter_by(loginid=loginid).first()

        if user_from_db:
            encrpted_password = hashlib.sha256(user_from_db.password.encode("utf-8")).hexdigest()
            # print(encrpted_password, '\t', hashlib.sha256(user_from_db.password.encode("utf-8")).hexdigest())
            if encrpted_password == hashlib.sha256(user_from_db.password.encode("utf-8")).hexdigest():
                access_token = create_access_token(identity=user_from_db.loginid) # create jwt token
                # print(access_token)
                return jsonify(access_token=access_token), 200
            return {"msg":"user creds do not match"}, 401
    return {"msg":"invalid data"}



@app.route("/tweets/<loginid>/add", methods=['POST'])
@jwt_required()
def create_tweet(loginid):
    current_user_loginid = get_jwt_identity()
    print(current_user_loginid)
    
    x = datetime.datetime.now()
    currentTime = str(x.strftime("%d")) +" "+ str(x.strftime("%B")) +"'"+ str(x.strftime("%y")) + " "+ str(x.strftime("%I")) +":"+ str(x.strftime("%M")) +" "+ str(x.strftime("%p"))
    print(currentTime)
    if request.form:
        tweet = request.form['tweet']
        stamp = currentTime
        post_img = request.files['file'].name
        user_id = current_user_loginid
        print(tweet,stamp, post_img,user_id)
        post = Post(tweet=tweet, stamp=currentTime, post_img=post_img, user_id=loginid)
        db.session.add(post)
        db.session.commit()
        to_timeline = Timeline(post_id=post.id)
        db.session.add(to_timeline)
        db.session.commit()
        return {"msg":"tweet created"}
    return {"msg":"tweet could not be created!"}

@app.route("/tweets/all", methods=['GET'])
@jwt_required()
def get_all_tweets():
    current_user_loginid = get_jwt_identity()
    print(current_user_loginid)

    all_tweets = Post.query.all()
    # tweet_dict = {}
    
    # print(all_tweets)
    tweets = Post.query.all()
    l1= [{"id": i.id, "tweet": i.tweet, "timestamp": i.stamp} for i in tweets]
    return {"tweets":l1}



@app.route("/tweets/users/all", methods=['GET'])
@jwt_required()
def get_all_users():
    current_user_loginid = get_jwt_identity()
    print(current_user_loginid)

    all_users = Post.query.all()
    # tweet_dict = {}
    
    # print(all_users)
    Users = User_mgmt.query.all()
    l1= [{"id": i.id, "firstname": i.firstname, "lastname": i.lastname, "image_file":i.image_file} for i in Users]
    return {"Users":l1}

