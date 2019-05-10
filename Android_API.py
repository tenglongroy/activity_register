import pymysql, json, jwt
from datetime import datetime, timedelta
from flask import Flask, render_template, g, session, redirect, url_for, request, flash, jsonify
#import codecs

import activity_model

from flask import Blueprint
#http://stackoverflow.com/questions/15231359/split-python-flask-app-into-multiple-files
android_api = Blueprint('android_api', __name__)
# We can define the prefix in one of two places: when we instantiate the Blueprint() 
# class or when we register it with app.register_blueprint()


tempFile = open('secret_key.dat','r')
secret_key = tempFile.read()
tempFile.close();



################################ from app.py ###################################

#Generates the Auth Token, return: string
def encode_auth_token(user_id):
#http://stackoverflow.com/questions/33198428/jwt-module-object-has-no-attribute-encode
    try:
        payload = {
            'exp': datetime.utcnow() + timedelta(days=30, seconds=0),
            'iat': datetime.utcnow(),
            'sub': user_id }
        #return jwt.encode(payload, app.secret_key, algorithm='HS256')
        #return jwt.encode(payload, android_api.secret_key, algorithm='HS256')
        return jwt.encode(payload, secret_key, algorithm='HS256').decode("utf-8")   #byte to string
    except Exception as e:
        return e
def decode_auto_token(token):
    try:
        #payload = jwt.decode(token, android_api.secret_key)
        payload = jwt.decode(token, secret_key)
        return payload['sub']
    except jwt.ExpiredSignatureError:
        return 0        #Signature expired. Please log in again.
    except jwt.InvalidTokenError:
        return -1       #Invalid token. Please log in again.

################################ end from ######################################










#flag 1 All good, flag 0 account login somewhere else, flag -1, first login, flag -2 token expired, flag 3 wrong token.
def android_check_userID_token(user_id, token):
    decode_flag = decode_auto_token(result['token'])
    if decode_flag == result['user_id']:        #token valid
        check_flag = check_token(result['user_id'], result['token'])
        if check_flag == 1:
            return 1
        elif check_flag == 0:       #flag 0, account login somewhere else
            return 0
        else:       #flag -1, first login.
            return -1
    elif decode_flag == 0:       #token expired
        return -2
    else:           #wrong token
        return -3







#login function, check authentication, then save the new token to database
@android_api.route('/android_login', methods=['GET', 'POST'])
def android_login():
    print("android_login")

    """reader = codecs.getreader("utf-8")
    result = json.loads(reader(request.json))"""
    result = request.json
    #result = json.loads(request.json)   #assume it's like [{'username':asdf, 'password':asdf}]
    if type(result) is list:
        result = result[0]
    if not result.get('username', None):
        return jsonify({'response_type': 'login', 'login': -2}), 200      #didn't receive username
    user_id = activity_model.check_auth(result['username'], result['password'])
    if user_id < 0:
        return jsonify({'response_type': 'login', 'login': -1}), 200      #Invalid username or password
    auth_token = encode_auth_token(user_id)
    print(str(auth_token)+ str(len(auth_token)))
    IPaddress = request.remote_addr
    activity_model.save_token(user_id, auth_token, IPaddress)
    return jsonify(response_type='login', login=1, user_id=user_id, token=auth_token), 200   #successfully login

#check if need to login again
@android_api.route('/android_check_login', methods=['GET', 'POST'])
def android_check_login():
    print("android_check_login")
    result = json.loads(request.json)
    if type(result) is list:
        result = result[0]
    if not result.get('user_id', None) or not result.get('token', None):
        return jsonify({'response_type': 'check_login', 'check_token': -4}), 200      #Invalid check

    flag = android_check_userID_token(result['user_id'], result['token'])
    return jsonify({'response_type': 'check_login','check_token': flag}), 200
    # if flag == 1:
    #     redirect(url_for('/android/index'))
    #     return jsonify({'check_token': flag, 'token': auth_token}), 200
    # else:
    #     return jsonify({'check_token': flag}), 200



###for logout, just do it in client-end, delete



@android_api.route('/android_show_activity_list', methods=['GET', 'POST'])
def android_show_activity_list():
    result = json.loads(request.json)   #might not logged in
    if type(result) is list:
        result = result[0]
    if not result.get('user_id', None) or not result.get('token', None):
        return jsonify({'response_type': 'show_activity_list', 'check_token': -4}), 200      #Invalid check

    flag = android_check_userID_token(result['user_id'], result['token'])
    if flag != 1:
        return jsonify({'response_type': 'show_activity_list', 'check_token': -4}), 200      #Invalid check

    act_list = activity_model.getActivityList()
    user_info = None
    join_list = None
    if session.get('logged_in'):
        user_info = activity_model.getUserInfo(session.get('user_id', -1))
        join_list = activity_model.getJoinedList(act_list, session.get('user_id', -1))
    pass


def android_show_specified_activity():
    pass


def android_show_user_profile():
    pass


def android_delete_activity():
    pass


def android_create_activity():
    pass


def android_join_activity():
    pass


def android_kick_activity():
    pass


def android_quit_activity():
    pass


def android_user_register():
    pass


def android_nickname_update():
    pass


def android_password_update():
    pass





if __name__ == '__main__':
    pass