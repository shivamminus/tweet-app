# from __main__ import db

# import app
from datetime import datetime

from flask_sqlalchemy import SQLAlchemy
from app import app
from app import db
from modals import Post, Timeline

from time import sleep

import csv

# file = open(r"elonmusk_tweets.csv")

# csv_data = csv.reader(file)
# rows = []
# for row in csv_data:
#         rows.append(row[2][2:])
# # print(type(rows[1][2:]))


def select_title(row):
    import random
    print(row)
    group_of_items = str(row).split(" ")  # a sequence or set will work here.
    print(group_of_items)
    num_to_select = 3 if len(str(row).split(" "))>= 5 else 1                         # set the number to select here.
    list_of_random_items = random.sample(group_of_items, num_to_select)
    print(list_of_random_items)
    print(" ".join(list_of_random_items))

    return " ".join(list_of_random_items)


def text_and_title():
    import csv

    file = open(r"elonmusk_tweets.csv")

    csv_data = csv.reader(file)
    tweet = {'title': None, 'text':None}
    rows = []
    x = datetime.now()
    currentTime = str(x.strftime("%d")) +" "+ str(x.strftime("%B")) +"'"+ str(x.strftime("%y")) + " "+ str(x.strftime("%I")) +":"+ str(x.strftime("%M")) +" "+ str(x.strftime("%p"))
    print(currentTime)
    loginid= 2
    i = 0
    for row in csv_data:
            if i<21:
                # rows.append(row[2][2:])
                title = select_title(row[2][2:])
                text = row[2][2:]
                print(title, "\t", text)
                post = Post(tweet=text, stamp=currentTime, post_img=None, user_id=loginid, tweet_title=title, like_count=0)
                print(f"loginid: {loginid} Like Count {post.like_count}")
                db.session.add(post)
                db.session.commit()
                to_timeline = Timeline(post_id=post.id)
                db.session.add(to_timeline)
                db.session.commit()
                sleep(1)
                i+=1
            else:
                break



text_and_title()


# print(type(rows[1][2:]))

# foo = str(rows[1]).split(" ")
# print(random.choice(foo))


