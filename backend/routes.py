from __main__ import db, app
from forms import Signup, Login, createTweet, UpdateProfile
from modals import User_mgmt, Post, Timeline, Retweet
from flask import request, jsonify, redirect, url_for
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
    result = Post.query.join(User_mgmt, Post.user_id == User_mgmt.id).add_columns(Post.id, User_mgmt.loginid, Post.tweet, Post.stamp).filter(Post.user_id == User_mgmt.id)
    # qr = db.session.query(Post, User_mgmt).filter(Post.user_id == User_mgmt.id)
    l2 = [{"id": i.id,"loginid":i.loginid, "tweet": i.tweet, "timestamp": i.stamp} for i in result]
    # l1= [{"id": i.id, "tweet": i.tweet, "timestamp": i.stamp} for i in tweets]
    return {"tweets":l2}



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

@app.route("/tweets/<username>/delete/<id>", methods=['DELETE'])
@jwt_required()
def delete_tweet(username, id):
    current_user_loginid = get_jwt_identity()
    if current_user_loginid == username:

        tweet = Post.query.get(id)
        author = User_mgmt.query.get(tweet.user_id)
        # print(current_user_loginid)
        # print(author.loginid)
        if author.loginid == current_user_loginid:

            db.session.delete(tweet)
            db.session.commit()
            result = Post.query.join(Timeline, Post.id == Timeline.post_id).add_columns(Timeline.id).filter(Post.id == Timeline.post_id)
            # check timeline table 
            return {"msg":f"Tweet {id} for the user : {username} deleted"}
    return {"msg":"Cannot delete another tweet"}


# post_id refers to the post which needs to be retweeted
@app.route('/retweet/<post_id>',methods=['GET','POST'])
@jwt_required()
def retweet(post_id):
    current_user_loginid = get_jwt_identity()
    if request.form:
        # below line fetched the Post which has id == post_id
        post = Post.query.get_or_404(post_id)
        print(post.id) #gives the id from the post which needs to be retweeted
        if post:
            # below line gives the retweet text which is added while retweeting
            new_tweet = request.form['retweet']
            if new_tweet:
                # below query will fetch us the user whose query is retweeted
                result = Post.query.join(User_mgmt, Post.user_id == User_mgmt.id).add_columns(User_mgmt.loginid).filter(Post.user_id == User_mgmt.id).order_by(Post('-id')).first()
                for i in result:
                    print("result:",i)
                # x = datetime.datetime.now()
                # currentTime = str(x.strftime("%d")) +" "+ str(x.strftime("%B")) +"'"+ str(x.strftime("%y")) + " "+ str(x.strftime("%I")) +":"+ str(x.strftime("%M")) +" "+ str(x.strftime("%p"))

                # retweet = Retweet(tweet_id=post.id,user_id=result.id,retweet_stamp=currentTime,retweet_text=new_tweet)
                # db.session.add(retweet)
                # db.session.commit()

                # to_timeline = Timeline(retweet_id=retweet.id)
                # print(dir(to_timeline))
                # print(to_timeline.retweet_id)
                # db.session.add(to_timeline)
                # db.session.commit()

                # q_result = Post.query.join(User_mgmt, Post.user_id == User_mgmt.id).add_columns(User_mgmt.loginid).filter(Post.user_id == User_mgmt.id).first()
                # q_result = db.session.query(Post).filter(Post.id == post_id).last()

                return {"msg": f"{current_user_loginid} Retweeted @ "}

    return {"msg":"could not retweet"}





@app.route("/tweets/<loginid>", methods=['GET'])
@jwt_required()
def get_all_tweets_of_a_user(loginid):
    current_user_loginid = get_jwt_identity()
    joined_result = Post.query.join(User_mgmt, Post.user_id == User_mgmt.id).add_columns(User_mgmt.id, User_mgmt.loginid, Post.tweet, Post.stamp).all()
    l1=[{"id": i.id, "loginid":i.loginid, "tweet":i.tweet, "timestamp":i.stamp} for i in joined_result]
    user_tweets = {}
    j = 0
    for dict_item in l1:
        for k,v in dict_item.items():
            if k == 'loginid':
                if loginid in v:
                    user_tweets[j] = dict_item
                    j+=1
    return {"data":user_tweets,"total_records":len(user_tweets)}


@app.route("/tweets/user/search/<loginid>", methods=['GET'])
@jwt_required()
def search_by_username(loginid):
    current_user_loginid = get_jwt_identity()
    users = User_mgmt.query.filter(User_mgmt.loginid.ilike(f"%{loginid}%")).all()
    l1=[{"loginid":i.loginid} for i in users]
    user_tweets = {}
    j = 0
    for dict_item in l1:
        for k,v in dict_item.items():
            if k == 'loginid':
                if loginid in v:
                    user_tweets[j] = dict_item
                    j+=1
    return {"data":user_tweets , "users_found": len(user_tweets)}


@app.route("/tweets/forgot" , methods=['GET'])
def search_by_full_username():
    if request.form:
        loginid = request.form['login-id']
        user_found = User_mgmt.query.filter(User_mgmt.loginid == loginid).first()
        if user_found:
            print(user_found.loginid)
            return {"forgot-password":f"http://localhost:5000/tweets/{user_found.loginid}/forgot"}
    return {"msg":"User does not exist"}


@app.route("/tweets/<loginid>/forgot" , methods=['PUT'])
def reset_password(loginid):
    if request.form:
        new_password = request.form['new-password']
        user_found = User_mgmt.query.filter(User_mgmt.loginid == loginid).first()
        encrypted_password = hashlib.sha256(user_found.password.encode("utf-8")).hexdigest()
        user_found.password = encrypted_password
        db.session.commit()
        return {"msg":"password updated"}
    return {"msg":"password could not be updated!"}