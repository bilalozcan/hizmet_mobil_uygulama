import 'package:hizmet_mobil_uygulama/models/User_.dart';
import 'package:hizmet_mobil_uygulama/services/AuthBase.dart';

class FakeAuthService implements AuthBase {
  String userID = "311812020503669";

  @override
  Future<User_> currentUser() async {
    return await Future.value(
        User_(userID: userID, email: "fakeMehmet@fake.com"));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User_> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => User_(
            userID: "google_user_id_123456",
            email: "fakeMehmetGoogle@fake.com"));
  }

  @override
  Future<User_> createUserWithEmailandPassword(
      String email, String password,String name, String surname,String username) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () => User_(
            userID: "created_user_id_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<User_> signInWithEmailandPassword(
      String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 2),
        () =>
            User_(userID: "signIn_user_id_123456", email: "fakeuser@fake.com"));
  }
}
