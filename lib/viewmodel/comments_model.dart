
import 'package:flutter/cupertino.dart';
import 'package:hizmet_mobil_uygulama/locator.dart';
import 'package:hizmet_mobil_uygulama/models/Comments.dart';
import 'package:hizmet_mobil_uygulama/repository/CommentsRepository.dart';
import 'package:hizmet_mobil_uygulama/services/CommentsBase.dart';

enum ViewState { Idle, Busy }

class CommentsModel with ChangeNotifier implements CommentsBase {
  ViewState _state = ViewState.Idle;
  CommentsRepository _commentsRepository=locator<CommentsRepository>();
  Comments _comment;
  List<Comments> _comments;


  List<Comments> get comments => _comments;

  set comments(List<Comments> value) {
    _comments = value;
  }

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
  }

  @override
  Future<Comments> createComment({senderID, content, degree,receiverID}) async {
    try{
      state=ViewState.Busy;
      _comment=await _commentsRepository.createComment(senderID: senderID,content: content,degree: degree,receiverID: receiverID);
      return _comment;
    }finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<List<Comments>> readComments(String userID) async{
   try{
     state=ViewState.Busy;
     _comments=await _commentsRepository.readComments(userID);
     return _comments;
   }finally{
     state=ViewState.Idle;
   }
  }

  Comments get comment => _comment;

  set comment(Comments value) {
    _comment = value;
  }

}