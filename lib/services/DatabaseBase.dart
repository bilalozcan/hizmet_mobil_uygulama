

import 'package:hizmet_mobil_uygulama/models/User_.dart';

abstract class DatabaseBase {
  Future<bool> saveUser(User_ user);
  Future<User_> readUser(String userID);
  //Future<bool> updateUserName(String userID, String yeniUserName);
  //Future<bool> updateProfilFoto(String userID, String profilFotoURL);
  /*Future<List<User_>> getUserwithPagination(
      User_ enSonGetirilenUser, int getirilecekElemanSayisi);
  Future<List<Konusma>> getAllConversations(String userID);
  Stream<List<Mesaj>> getMessages(String currentUserID, String konusulanUserID);
  Future<bool> saveMessage(Mesaj kaydedilecekMesaj);
  Future<DateTime> saatiGoster(String userID);*/
}