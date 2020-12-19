import 'package:flutter/material.dart';

class Comments
{
  String _senderID;
  String _content;
  double _degree;

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  double get degree => _degree;

  set degree(double value) {
    _degree = value;
  }

  String get senderID => _senderID;

  set senderID(String value) {
    _senderID = value;
  }

  Comments({@required String senderID, @required String content, @required double degree})
  {
    this._senderID=senderID;
    this._content=content;
    this._degree=degree;
  }

  Comments.fromMap(Map<String, dynamic> parsedMap)
  :_senderID=parsedMap['senderID'],
  _content=parsedMap['content'],
  _degree = parsedMap['degree'];

  Map<String, dynamic> toMap()
  {
    return { 'senderID':_senderID,'content':content,'degree':_degree};
  }

}