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

  String get email => _email;

  set email(String value) {
    _email = value;
  }

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

  User_.Info(
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
          'https://firebasestorage.googleapis.com/v0/b/hizmetuygulamasi.appspot.com/o/default_profile.png?alt=media&token=0000745a-9b5e-4b84-8efe-fa6c83206b1b',
      'createdAt': _createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': _updatedAt ?? FieldValue.serverTimestamp(),
      'dateOfBirth': _dateOfBirth ?? FieldValue.serverTimestamp(), //Doğum tarihini kullanıcıdan almadığımız için bu şekilde
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

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get surname => _surname;

  set surname(String value) {
    _surname = value;
  }

  String get profileURL => _profileURL;

  set profileURL(String value) {
    _profileURL = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  DateTime get updatedAt => _updatedAt;

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  DateTime get dateOfBirth => _dateOfBirth;

  set dateOfBirth(DateTime value) {
    _dateOfBirth = value;
  }

  int get firstTime => _firstTime;

  set firstTime(int value) {
    _firstTime = value;
  }

  int get degree => _degree;

  set degree(int value) {
    _degree = value;
  }
}
