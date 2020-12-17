
import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';

abstract class HizmetBase {
  Future<Hizmet> createHizmet({
    @required hizmetID,
    @required title,
    @required category,
    @required subCategory,
    @required publisher,
    @required detail,
    @required address,
    @required payment,
  });
  Future<Hizmet> setHizmet(Hizmet hizmet);
  Future<Hizmet> readHizmet(String hizmetID, String category, String subCategory);
  Future<List<Hizmet>> readFilterHizmet({String category, String subCategory});

}