

import 'package:hizmet_mobil_uygulama/models/Hizmet.dart';
import 'package:hizmet_mobil_uygulama/models/User_.dart';

abstract class DatabaseBase {
  Future<bool> saveUser(User_ user);
  Future<User_> readUser(String userID);
  //Future<bool> updateUserName(String userID, String yeniUserName);
  Future<bool> updateProfilePhoto(String userID, String profilePhotoUrl);
  Future<bool> createHizmet(Hizmet hizmet);
  Future<Hizmet> readHizmet(String category, String subCategory,String hizmet);
  Future<List<Hizmet>> readFilterHizmet({String category, String subCategory,String hizmet,List<String> categories,List<List<String>> subCategories});
  /*Future<List<User_>> getUserwithPagination(
      User_ enSonGetirilenUser, int getirilecekElemanSayisi);
  Future<List<Konusma>> getAllConversations(String userID);
  Stream<List<Mesaj>> getMessages(String currentUserID, String konusulanUserID);
  Future<bool> saveMessage(Mesaj kaydedilecekMesaj);
  Future<DateTime> saatiGoster(String userID);*/

}