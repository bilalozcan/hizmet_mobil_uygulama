import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'User_.dart';

class Hizmet {
  String _title;
  String _category;
  String _subCategory;
  String _publisher;
  String _detail;
  DateTime _publishedAt;
  String _address; //İl-İlçe-Mahalle vs tutuldugu bir model sınıf olabilir
  double _payment;
  int _review;

  Hizmet();


  Hizmet.Info(
      this._title,
      this._category,
      this._subCategory,
      this._publisher,
      this._detail,
      this._address,
      this._payment,);

  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      'category': _category,
      'subCategory': _subCategory,
      'publisher': _publisher,
      'detail': _detail,
      'publishedAt': _publishedAt ?? FieldValue.serverTimestamp(),
      'address': _address,
      'payment': _payment,
      'review': _review ?? 0,
    };
  }

  Hizmet.fromMap(Map<String, dynamic> parsedMap)
      :
        _title = parsedMap['title'],
        _category = parsedMap['category'],
        _subCategory = parsedMap['subCategory'],
        _publisher = parsedMap['publisher'],
        _detail = parsedMap['detail'],
        _publishedAt = (parsedMap['publishedAt'] as Timestamp).toDate(),
        _address = parsedMap['address'],
        _payment = parsedMap['payment'],
        _review = parsedMap['review'];

  @override
  String toString() {
    return 'Hizmet{title: $_title, category: $_category, subCategory: $_subCategory, publisher $_publisher, detail: $_detail, publishedAt: $_publishedAt, address: $_address, payment: $_payment, review: $_review}';
  }

  int get review => _review;

  set review(int value) {
    _review = value;
  }

  double get payment => _payment;

  set payment(double value) {
    _payment = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  DateTime get publishedAt => _publishedAt;

  set publishedAt(DateTime value) {
    _publishedAt = value;
  }

  String get detail => _detail;

  set detail(String value) {
    _detail = value;
  }


  String get publisher => _publisher;

  set publisher(String value) {
    _publisher = value;
  }

  String get subCategory => _subCategory;

  set subCategory(String value) {
    _subCategory = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

}
