import 'package:flutter/material.dart';

class Comments
{
  String _senderID;
  String _content;
  int _degree;
  String _receiverID;


  String get receiverID => _receiverID;

  set receiverID(String value) {
    _receiverID = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  int get degree => _degree;

  set degree(int value) {
    _degree = value;
  }

  String get senderID => _senderID;

  set senderID(String value) {
    _senderID = value;
  }

  Comments({@required String senderID, @required String content, @required int degree,@required String receiverID})
  {
    this._senderID=senderID;
    this._content=content;
    this._degree=degree;
    this.receiverID=receiverID;
  }

  Comments.fromMap(Map<String, dynamic> parsedMap)
  :_senderID=parsedMap['senderID'],
  _content=parsedMap['content'],
  _degree = parsedMap['degree'],
  _receiverID= parsedMap['receiverID'];

  Map<String, dynamic> toMap()
  {
    return { 'senderID':_senderID,'content':content,'degree':_degree,'receiverID':_receiverID};
  }
 @override
  String toString() {
    // TODO: implement toString
    return 'Comment: senderID:$senderID, content:$content , degree: $degree , receiverID:$receiverID';
  }
}