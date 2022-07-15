from __main__ import db, app

from werkzeug.security import generate_password_hash, check_password_hash
from flask_cors import cross_origin
from pyparsing import identbodychars
from modals import User_mgmt, Post, Timeline, Retweet, Like, InvalidToken
from flask import request, jsonify, redirect, url_for
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_jwt_extended import (
    create_access_token,
    create_refresh_token,
    jwt_required,
    get_jwt_identity,
    get_jwt,
)
import hashlib
import json
import datetime
import traceback
import ast
# IMPLEMENTING ELK
import logging



logging.basicConfig(filename = 'tweet-app.log', level=logging.DEBUG, format=f'%(asctime)s %(levelname)s %(name)s %(threadName)s : %(message)s')


jwt = JWTManager(app) # initialize JWTManager
app.config['JWT_SECRET_KEY'] = 'Your_Secret_Key'
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = datetime.timedelta(days=1) # define the life span of the token

@app.route("/", methods=['GET'])
@cross_origin()
def myfun():

    app.logger.info('HEALTH CHECK OK!!!!')
    print("reached 1st url")
    return {"msg":"success"}



@app.route('/tweets/register',methods=['GET','POST'])
@cross_origin()
def register():

    # add this to those routes which you want the user from going to if he/she is already logged in
    #if current_user.is_authenticated:
    #    return redirect(url_for(''))
    try: 
        print(ast.literal_eval(request.data.decode()))
        request.data = ast.literal_eval(request.data.decode())
        if request.data:
            firstname = request.data['first_name']
            lastname = request.data['last_name']
            email = request.data['email']
            loginid = request.data['loginid']
            password = request.data['password']
            contact = request.data['contact']
            # password = hashlib.sha256(password.encode("utf-8")).hexdigest()
            password = generate_password_hash(password)
            print(firstname, lastname, email, loginid, password, contact)
            new_user = User_mgmt(email=email, firstname=firstname,lastname=lastname,password=password, loginid=loginid, contact=contact)
            id = db.session.add(new_user)
            db.session.commit()
            app.logger.info("USER CREATED SUCCESSFULLY! {id}")
            return {"msg":new_user.loginid}
    except Exception as e:
        app.logger.error("User Could not be created !", traceback.format_exc())
        return {"error":"User Not Created"}, 400
    return {"error":"Could not register user"}




@app.route('/login', methods=['POST'])
@cross_origin()
def login():
    try:
        print(request.data)
        app.logger.info(f"API : /login triggered! ")
        print(ast.literal_eval(request.data.decode()))
        if request.data:
            request.data = ast.literal_eval(request.data.decode(encoding="utf-8"))
            loginid = request.data['loginid']
            password = request.data['password']
            print(password)
            rec_password = hashlib.sha256(password.encode("utf-8")).hexdigest()
            # print(rec_password)
            user_from_db = User_mgmt.query.filter_by(loginid=loginid).first()

            if user_from_db and check_password_hash(user_from_db.password, password):
                encrpted_password = hashlib.sha256(user_from_db.password.encode("utf-8")).hexdigest()
                # print(encrpted_password, '\t', hashlib.sha256(user_from_db.password.encode("utf-8")).hexdigest())
                print(encrpted_password,"\n",rec_password)
                # if encrpted_password == rec_password:
                if password:
                    access_token = create_access_token(identity=user_from_db.loginid) # create jwt token
                    refresh_token = create_refresh_token(identity=user_from_db.loginid)
                    # print(access_token)
                    app.logger.info(f"Login Successfull by user {loginid}")
                    return {"token":access_token, "refreshToken":refresh_token, 'loginid':user_from_db.loginid, "user_id":user_from_db.id}, 200
                app.logger.warn("Credentials do not match")
                return {"error":"user creds do not match"}, 401
    except Exception as e:
        app.logger.error("USER NOT Registered", traceback.format_exc())
    return {"error":"invalid data"}

@app.route("/api/checkiftokenexpire", methods=["POST"])
@jwt_required()
@cross_origin()
def check_if_token_expire():
    return jsonify({"success": True})


@app.route("/api/refreshtoken", methods=["POST"])
@jwt_required(refresh=True)
@cross_origin()
def refresh():
    identity = get_jwt_identity()
    token = create_access_token(identity=identity)
    return jsonify({"token": token})

@app.route("/api/logout/access", methods=["POST"])
@jwt_required()
@cross_origin()
def access_logout():
    jti = get_jwt()["jti"]
    try:
        invalid_token = InvalidToken(jti=jti)
        invalid_token.save()
        return jsonify({"success": True})
    except Exception as e:
        print(e)
        return {"error": e.message}

@app.route("/api/logout/refresh", methods=["POST"])
@jwt_required()
@cross_origin()
def refresh_logout():
    jti = get_jwt()["jti"]
    try:
        invalid_token = InvalidToken(jti=jti)
        invalid_token.save()
        return jsonify({"success": True})
    except Exception as e:
        print(e)
        return {"error": e.message}

@app.route("/tweets/<loginid>/add", methods=['POST'])
@jwt_required()
@cross_origin()
def create_tweet(loginid):
    try:
        
        current_user_loginid = get_jwt_identity()
        app.logger.info(f"API : /tweets/all by user : {current_user_loginid}")
        # print(current_user_loginid)
        
        x = datetime.datetime.now()
        currentTime = str(x.strftime("%d")) +" "+ str(x.strftime("%B")) +"'"+ str(x.strftime("%y")) + " "+ str(x.strftime("%I")) +":"+ str(x.strftime("%M")) +" "+ str(x.strftime("%p"))
        print(currentTime)
        post_img = 'default.jpg'
        if request.data:
            request.data = ast.literal_eval(request.data.decode(encoding="utf-8"))
            tweet = request.data['tweet']
            title = request.data['title']
            stamp = currentTime
            # if request.data['']:
            #     post_img = request.data['tweet']
            user_id = current_user_loginid
            print(tweet,stamp, post_img,user_id)

            post = Post(tweet=tweet, stamp=currentTime, post_img=post_img, user_id=loginid, tweet_title=title, like_count=0)
            print(f"loginid: {loginid} Like Count {post.like_count}")
            db.session.add(post)
            db.session.commit()
            to_timeline = Timeline(post_id=post.id)
            db.session.add(to_timeline)
            db.session.commit()
            app.logger.info("Tweet Created and store in DB")
            return jsonify({"success": "true"})
    except Exception as e:
        app.logger.error("TWEET COULD NOT BE CREATED",traceback.format_exc())
        return {"error":"tweet could not be created!"}, 500

@app.route("/tweets/all", methods=['GET'])
@jwt_required()
@cross_origin()
def get_all_tweets():
    try:

        current_user_loginid = get_jwt_identity()
        app.logger.info(f"API : /tweets/all by user : {current_user_loginid}")
        print(current_user_loginid)

        # all_tweets = Post.query.all()
        # tweet_dict = {}
        
        # print(all_tweets)
        # tweets = Post.query.all()
        l2 = get_all_tweets_base(current_user_loginid)
        app.logger.info("Successfully fetched the tweets")
    
        return {"tweets":l2 }
    except Exception as e:
        app.logger.error("Could not fetch tweet: \n"+traceback.format_exc())
        return {"error": traceback.format_exc()}

def get_all_tweets_base(current_user_loginid):
    try:
        result = Post.query.join(User_mgmt, Post.user_id == User_mgmt.id).add_columns(Post.id, User_mgmt.loginid, Post.tweet, Post.stamp, Post.tweet_title, Post.like_count).filter(Post.user_id == User_mgmt.id)
        user_id = User_mgmt.query.filter(User_mgmt.loginid == current_user_loginid).first()
        
        # liked = Like.query.join(Post, Post.user_id == Like.user_id).filter(Post.user_id==Like.user_id).all()
        liked = Like.query.filter(user_id.id==Like.user_id).all()
        

        tweet_id_col = [i.tweet_id for i in liked]

        print("TWEET ID COL", tweet_id_col)


        retweet_data = Retweet.query.join(User_mgmt, User_mgmt.id == Retweet.user_id).add_columns(User_mgmt.loginid, Retweet.tweet_id, Retweet.user_id, Retweet.retweet_text).all()
        retweet_data = [{"loginid":i.loginid, "tweet_id":i.tweet_id, "retweet_text":i.retweet_text} for i in retweet_data][::-1]


        l2 = [{"id": i.id,"loginid":i.loginid, "title":i.tweet_title, "tweet": i.tweet, "timestamp": i.stamp, "isOwner":i.loginid == current_user_loginid, "retweet": [{"loginid": k['loginid'], "retweet_text": k['retweet_text']} for k in retweet_data if k['tweet_id']==i.id],"like_count":i.like_count, "already_liked": True if i.id in tweet_id_col else False} for i in result]

        app.logger.info("Successfully fetched the tweets")
    
        return {"tweets":l2[::-1] }
    except Exception as e:
        app.logger.error("Could not fetch tweet: \n"+traceback.format_exc())
        return {"error": traceback.format_exc()}



@app.route("/tweets/users/all", methods=['GET'])
@jwt_required()
@cross_origin()
def get_all_users():
    current_user_loginid = get_jwt_identity()
    app.logger.info(f"API : /tweets/users/all by user : {current_user_loginid}")
    # print(current_user_loginid)

    all_users = Post.query.all()
    # tweet_dict = {}
    
    # print(all_users)
    Users = User_mgmt.query.all()
    
    l1= [{"id": i.id, "firstname": i.firstname, "lastname": i.lastname, "image_file":i.image_file} for i in Users]
    return {"Users":l1} 


    

@app.route("/tweets/<username>/delete/<id>", methods=['DELETE'])
@jwt_required()
@cross_origin()
def delete_tweet(username, id):
    current_user_loginid = get_jwt_identity()
    app.logger.info(f"API : /tweets/<username>/delete/<id> by user: {current_user_loginid}")
    try:
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
                app.logger.info("Tweet Successfully deleted ")
                return {"msg":f"Tweet {id} for the user : {username} deleted"}
    except Exception as e:
        app.logger.error("Cannot delete the Tweet: \n"+e.with_traceback())
    return {"error":"Cannot delete another tweet"}

# post_id refers to the post which needs to be retweeted
@app.route('/retweet/<post_id>',methods=['GET','POST'])
@jwt_required()
@cross_origin()
def retweet(post_id):
    current_user_loginid = get_jwt_identity()
    app.logger.info(f"API : /retweet/<post_id> by user: {current_user_loginid}")
    if request.form:    
        
        whose_post = request.form['loginid']
        # below line fetched the Post which has id == post_id
        post = Post.query.get_or_404(post_id)
        print(post.id) #gives the id from the post which needs to be retweeted
        if post:
            # below line gives the retweet text which is added while retweeting
            new_tweet = request.form['retweet']
            if new_tweet:
                # below query will fetch us the user whose query is retweeted
                result = Post.query.join(User_mgmt, Post.user_id == User_mgmt.id).add_columns(User_mgmt.id ,User_mgmt.loginid).filter(Post.user_id == User_mgmt.id).first()
                for i in result:
                    print("result:",i)
                x = datetime.datetime.now()
                currentTime = str(x.strftime("%d")) +" "+ str(x.strftime("%B")) +"'"+ str(x.strftime("%y")) + " "+ str(x.strftime("%I")) +":"+ str(x.strftime("%M")) +" "+ str(x.strftime("%p"))
                current_user = User_mgmt.query.filter(User_mgmt.loginid == current_user_loginid).first()
                retweet = Retweet(tweet_id=post.id,user_id=current_user.id,retweet_stamp=currentTime,retweet_text=new_tweet)
                db.session.add(retweet)
                db.session.commit()

                to_timeline = Timeline(retweet_id=retweet.id, post_id=post.id)
                print(dir(to_timeline))
                print(to_timeline.retweet_id)
                db.session.add(to_timeline)
                db.session.commit()
                app.logger.info(f"RETWEET SUCCESSFUL by USER: {current_user_loginid} of {whose_post}")
                return {"msg": f"{current_user_loginid} Retweeted @ {whose_post}"}

    return {"error":"could not retweet"}





@app.route("/tweets/<loginid>", methods=['GET'])
@jwt_required()
@cross_origin()
def get_all_tweets_of_a_user(loginid):
    current_user_loginid = get_jwt_identity()
    app.logger.info(f"API :/tweets/<loginid> by user: {current_user_loginid}")
    try:


        response = get_all_tweets_base(current_user_loginid)
        response = [k for k in response if k['loginid'] == loginid]
        return {"data":response,"total_records":len(response)}
        # print(response)

        # joined_result = Post.query.join(User_mgmt, Post.user_id == User_mgmt.id).add_columns(User_mgmt.id, User_mgmt.loginid, Post.tweet, Post.stamp).all()
        # l1=[{"id": i.id, "loginid":i.loginid, "tweet":i.tweet, "timestamp":i.stamp} for i in joined_result]
        # user_tweets = []
        # j = 0
        # print(l1)
        # for dict_item in l1:
        #     for k,v in dict_item.items():
        #         if k == 'loginid':
        #             if loginid in v:
        #                 user_tweets.append(dict_item)
        #                 # j+=1
        # return {"data":user_tweets,"total_records":len(user_tweets)}
    except Exception as e:
        app.logger.error("ERROR FETCHING DATA FROM DB: \n"+ e.with_traceback())
        return {"error": "Could Not find any Tweet"}


@app.route("/tweets/user/search/<loginid>", methods=['GET'])
@jwt_required()
@cross_origin()
def search_by_username(loginid):
    current_user_loginid = get_jwt_identity()
    app.logger.info(f"API :/tweets/<loginid> by user: {current_user_loginid}")
    try:

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
        
        user_list = [item for item in user_tweets.values()]
        

        return {"data":user_list , "users_found": len(user_tweets)}
    except Exception as e:
        app.logger.error("Could not retreive Tweet: "+ e.with_traceback())
        return {"error": "Error Occured! Check logs for the details"}

@app.route("/tweets/forgot" , methods=['GET'])
@cross_origin()
def search_by_full_username():
    app.logger.info("API: /tweets/forgot triggered!")
    try:

        if request.form:
            loginid = request.form['login-id']
            user_found = User_mgmt.query.filter(User_mgmt.loginid == loginid).first()
            if user_found:
                print(user_found.loginid)
                return {"forgot-password":f"http://localhost:5000/tweets/{user_found.loginid}/forgot"}
        return {"error":"User does not exist"}
    except Exception as e:
        app.logger.error("Error Occured! \n"+e.with_traceback())
        return {"error":"Error Occured see logs for details"}


@app.route("/tweets/<loginid>/forgot" , methods=['PUT'])
@cross_origin()
def reset_password(loginid):
    try:

        if request.form:
            new_password = request.form['new-password']
            user_found = User_mgmt.query.filter(User_mgmt.loginid == loginid).first()
            # encrypted_password = hashlib.sha256(new_password.encode("utf-8")).hexdigest()
            password = generate_password_hash(new_password)
            user_found.password = password
            db.session.commit()
            return {"msg":"password updated"}
        return {"error":"password could not be updated!"}
    except Exception as e:
        app.logger.error("Error Occured, Check Logs for detail\n"+e.with_traceback())



@app.route("/tweets/<username>/like", methods=['GET', 'POST'])
@jwt_required()
@cross_origin()
def like_tweet(username):
    current_user_loginid = get_jwt_identity()
    app.logger.info(f"API: /tweets/<username>/like by user: {current_user_loginid}")
    try:
        # if request.data:
        #     request.data = ast.literal_eval(request.data.decode(encoding="utf-8"))
        #     print(request.data)
        # if current_user_loginid == username:
        if request.form:
            print(request.form['already-liked'])
            if request.form['already-liked'] !="false":
                return {"error":"already-liked"}
        data = request.form
        like = Like(
            user_id = data["user_id"],
            tweet_id = data["tweet_id"],
            like_count = None
        )
        db.session.add(like)
        db.session.commit()

            # return {"liked": str(like.to_dict())}
        return {"error":"invalid User"}
    except Exception as e:
        app.logger.error("Error Occured, Check logs for detail\n"+e.with_traceback())
        return {"error":"Something went wrong!"}


@app.route("/tweets/<username>/update/<post_id>", methods=['PUT'])
@cross_origin()
@jwt_required()
def update_tweet(username, post_id):
    current_user_loginid = get_jwt_identity()
    app.logger.info(f"API: /tweets/<username>/update/<post_id> by user: {current_user_loginid}")
    try:

        if current_user_loginid == username:

            if request.form:
                updated_post_text = request.form['updated-text']
                if request.files['file'].name:
                    post_img = request.files['file'].name   
                x = datetime.datetime.now()
                currentTime = str(x.strftime("%d")) +" "+ str(x.strftime("%B")) +"'"+ str(x.strftime("%y")) + " "+ str(x.strftime("%I")) +":"+ str(x.strftime("%M")) +" "+ str(x.strftime("%p"))
                res = Post.query.filter(Post.id==post_id).first()
                res.tweet = updated_post_text
                if post_img:
                    res.post_img = post_img
                # res.stamp = currentTime


                db.session.commit()

                return {"msg":"Post updated successfully!"}
    except Exception as e:
        app.logger.error("Something Went Wrong! Check Logs for error!\n"+e.with_traceback())
    
    return {"error":"Can not update!"}

@app.route("/deleteAccount" , methods=['DELETE'])
@cross_origin()
@jwt_required()
def delete_account():
    current_user_loginid = get_jwt_identity()
    app.logger.info("API: /tweets/deleteaccount triggered!")
    try:
        user = User_mgmt.query.filter(User_mgmt.loginid == current_user_loginid).first()

        posts = Post.query.filter(Post.user_id == user.id).all()
        ids = [i.id for i in posts]
        for id in ids:
            Timeline.query.filter(Timeline.post_id == id).delete()
        Like.query.filter(Like.user_id == user.id).delete()
        Retweet.query.filter(Retweet.user_id == user.id).delete()
        Post.query.filter(Post.user_id == user.id).delete()
        User_mgmt.query.filter(User_mgmt.id == user.id).delete()
        db.session.commit()
        return {"msg":f"user {current_user_loginid} deleted"}
    except Exception as e:
        app.logger.error("Error Occured! \n"+e.with_traceback())
        return {"error":"Error Occured see logs for details"}