import 'package:get_it/get_it.dart';
import 'package:hizmet_mobil_uygulama/repository/HizmetRepository.dart';
import 'package:hizmet_mobil_uygulama/repository/UserRepository.dart';
import 'package:hizmet_mobil_uygulama/services/FakeAuthService.dart';
import 'package:hizmet_mobil_uygulama/services/FirebaseAuthService.dart';
import 'package:hizmet_mobil_uygulama/services/FirebaseStorageService.dart';
import 'package:hizmet_mobil_uygulama/services/FirestoreDBService.dart';

GetIt locator = GetIt.I;

void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirebaseStorageService());
  locator.registerLazySingleton(() => HizmetRepository());
}