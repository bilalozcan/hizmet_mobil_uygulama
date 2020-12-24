import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Comments.dart';

abstract class CommentsBase {
  Future<Comments> createComment({@required senderID, @required content, @required degree,@required receiverID});
  Future<List<Comments>> readComments(String userID);
}
