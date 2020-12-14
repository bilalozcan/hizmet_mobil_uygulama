import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User_ {
  String _userID;
  String _email;
  String _username;
  String _name;
  String _surname;
  String _profileURL;
  DateTime _createdAt;
  DateTime _updatedAt;
  DateTime _dateOfBirth;
  int _firstTime = 0;
  int _degree;

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  User_({
    @required userID,
    @required email,
  }) {
    this._userID = userID;
    this._email = email;
  }

  User_.all(
      {@required userID,
      @required email,
      @required username,
      @required name,
      @required surname}) {
    this._userID = userID;
    this._email = email;
    this._username = username;
    this._name = name;
    this._surname = surname;
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': _userID,
      'email': _email,
      'username': _username,
      'name': _name,
      'surname': _surname,
      'profileURL': _profileURL ??
          'https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png',
      'createdAt': _createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': _updatedAt ?? FieldValue.serverTimestamp(),
      'dateOfBirth': _dateOfBirth,
      'degree': _degree ?? 0,
    };
  }

  User_.fromMap(Map<String, dynamic> parsedMap)
      : _userID = parsedMap['userID'],
        _email = parsedMap['email'],
        _username = parsedMap['username'],
        _name = parsedMap['name'],
        _surname = parsedMap['surname'],
        _profileURL = parsedMap['profileURL'],
        _createdAt = (parsedMap['createdAt'] as Timestamp).toDate(),
        _updatedAt = (parsedMap['updatedAt'] as Timestamp).toDate(),
        _dateOfBirth = (parsedMap['dateOfBirth'] as Timestamp).toDate(),
        _degree = parsedMap['degree'];

  @override
  String toString() {
    return 'User{userID: $_userID, email: $_email, username: $_username, name: $_name, surname: $_surname, profileURL: $_profileURL, createdAt: $_createdAt, updatedAt: $_updatedAt, dateOfBirth: $_dateOfBirth, degree: $_degree}';
  }
}
