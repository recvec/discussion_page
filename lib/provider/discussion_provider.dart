import 'dart:convert';
import 'dart:math';

import 'package:discussion_page/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/html.dart';

const addCommentCommand = "add_comment";
const deleteCommentCommand = "delete_comment";
const likeCommentCommand = 'like_comment';
const dislikeCommentCommand = 'dislike_comment';
const updateCommentCommand = 'update_comment';
const splitter = ":::";

class DiscussionProvider extends ChangeNotifier{
  HtmlWebSocketChannel channel;
var channelStream;
  final formKey = GlobalKey<FormState>();

TextEditingController authorFieldController;

TextEditingController textFieldController ;

 addComment(BuildContext context){
   if (formKey.currentState.validate()) {

     var newComment = json.encode(Comment(
         id: Random().nextInt(53333).toString(),
         authorName: authorFieldController.text,
         creationTime: DateFormat('kk:mm:ss EEE d MMM').format(DateTime.now()),
         text: textFieldController.text,)
         .toJson());

     channel.sink.add(addCommentCommand + splitter + newComment);
     print("addComment: Sended");
     Navigator.of(context).pop();
   }
 }

 deleteComment(String id){
   channel.sink.add(deleteCommentCommand + splitter + id);
   print("deleteComment: Sended");
 }
likeComment(String id){
  channel.sink.add(likeCommentCommand+ splitter + id);
  print("likeComment: Sended");
}
  dislikeComment(String id){
    channel.sink.add(dislikeCommentCommand+ splitter + id);
    print("dislikeComment: Sended");
  }

 updateComment(String id, String text){
   channel.sink.add(updateCommentCommand + splitter + id + splitter + text);
   print("updateComment: Sended");
 }
  DiscussionProvider(){
    channel = HtmlWebSocketChannel.connect("ws://localhost:37777");
    channelStream = channel.stream.asBroadcastStream();
    authorFieldController = TextEditingController();
    textFieldController = TextEditingController();
    print("channel inited");
  }



}