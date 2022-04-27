from __main__ import db

class User_mgmt(db.Model):
    id = db.Column(db.Integer,primary_key=True)
    email = db.Column(db.String(50),nullable=False,unique=True)
    password = db.Column(db.String(150),nullable=False)
    firstname = db.Column(db.String(50), nullable=False)
    lastname = db.Column(db.String(50), nullable=False)
    contact = db.Column(db.String(12), nullable=False)
    loginid = db.Column(db.String(50), nullable=False, unique=True)
    image_file = db.Column(db.String(20),nullable=True,default='default.jpg')
    bg_file = db.Column(db.String(20),nullable=True,default='default_bg.jpg')
    bio = db.Column(db.String(200),nullable=True)
    date = db.Column(db.String(20),nullable=True)
    bday = db.Column(db.String(10),nullable=True)

    posts = db.relationship('Post',backref='author',lazy=True)
    retwitted = db.relationship('Retweet',backref='retwitter',lazy=True)



class Post(db.Model):
    id = db.Column(db.Integer,primary_key=True)
    tweet = db.Column(db.String(500),nullable=False)
    stamp = db.Column(db.String(20),nullable=False)
    post_img = db.Column(db.String(20))
    user_id = db.Column(db.Integer,db.ForeignKey('user_mgmt.id'),nullable=False)

    retweets = db.relationship('Retweet',backref='ori_post',lazy=True)
    timeline = db.relationship('Timeline',backref='from_post',lazy=True)


class Retweet(db.Model):
    id = db.Column(db.Integer,primary_key=True)
    tweet_id = db.Column(db.Integer,db.ForeignKey('post.id'))
    user_id = db.Column(db.Integer,db.ForeignKey('user_mgmt.id'),nullable=False)
    retweet_stamp = db.Column(db.String(20),nullable=False)
    retweet_text = db.Column(db.String(500),nullable=False)

    timeline = db.relationship('Timeline',backref='from_retweet',lazy=True)

class Timeline(db.Model):
    id = db.Column(db.Integer,primary_key=True)
    post_id = db.Column(db.Integer,db.ForeignKey('post.id'),default=None)
    retweet_id = db.Column(db.Integer,db.ForeignKey('retweet.id'),default=None)