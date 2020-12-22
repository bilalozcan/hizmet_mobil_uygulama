import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/repository/HizmetRepository.dart';
import 'package:hizmet_mobil_uygulama/services/HizmetBase.dart';

enum ViewState { Idle, Busy }

class HizmetModel with ChangeNotifier implements HizmetBase {
  ViewState _state = ViewState.Idle;
  HizmetRepository _hizmetRepository = locator<HizmetRepository>();
  Hizmet _hizmet;
  List<Hizmet> hizmetler;

  Hizmet get hizmet => _hizmet;

  set hizmet(Hizmet value) {
    _hizmet = value;
  }

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  ViewState get state => _state;

  @override
  Future<Hizmet> createHizmet(
      {title,
      category,
      subCategory,
      hizmet,
      publisher,
      detail,
      address,
      payment}) async {
    try {
      state = ViewState.Busy;
      _hizmet = await _hizmetRepository.createHizmet(
          title: title,
          category: category,
          subCategory: subCategory,
          hizmet: hizmet,
          publisher: publisher,
          detail: detail,
          address: address,
          payment: payment);
      return _hizmet;
    } finally {
      state = ViewState.Idle;
    }
  }

  //TEK BİR HİZMETİN DETAYLARINI EKRANDA GÖSTERİRKEN
  @override
  Future<Hizmet> readHizmet(String category, String subCategory) {
    // TODO: implement readHizmet
    throw UnimplementedError();
  }

  @override
  Future<List<Hizmet>> readFilterHizmet(
      {String category, String subCategory, String hizmet}) async {
    try {
      state = ViewState.Busy;
      hizmetler = await _hizmetRepository.readFilterHizmet(
          category: category, subCategory: subCategory, hizmet: hizmet);
      if (hizmetler != null) {
        debugPrint("hizmetler null değil");
        return hizmetler;
      } else {
        debugPrint("hizmetler null geldi");
        return null;
      }
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<Hizmet> setHizmet(Hizmet hizmet) {
    // TODO: implement setHizmet
    throw UnimplementedError();
  }
}
