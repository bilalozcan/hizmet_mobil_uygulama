import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/models/Comments.dart';
import 'package:hizmet_mobil_uygulama/services/CommentsBase.dart';
import 'package:hizmet_mobil_uygulama/services/FirestoreDBService.dart';

enum AppMode { DEBUG, RELEASE }
AppMode appMode= AppMode.RELEASE;
class CommentsRepository implements CommentsBase{
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  @override
  Future<Comments> createComment({senderID, content, degree,receiverID}) async {
    if(appMode==AppMode.DEBUG)
      {
        return Comments(content: content,senderID: senderID,degree: degree,receiverID: receiverID);
      }
    else{
      Comments _comment=Comments(content: content,senderID: senderID,degree: degree,receiverID: receiverID);
      bool result = await _firestoreDBService.createComment(_comment);
    }
    return null;
  }

  @override
  Future<List<Comments>> readComments(String userID) async {
    if(appMode==AppMode.DEBUG)
      {
        return null;
      }
    else{
      List<Comments> comments=await _firestoreDBService.readComments(userID);
      return comments;
    }
  }

}