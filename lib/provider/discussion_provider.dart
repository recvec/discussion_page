import 'dart:convert';
import 'dart:math';

import 'package:discussion_page/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
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

  DiscussionProvider(){
    channel = HtmlWebSocketChannel.connect("ws://localhost:37777");
    channelStream = channel.stream.asBroadcastStream();
    authorFieldController = TextEditingController();
    textFieldController = TextEditingController();
    print("channel inited");
  }


  showBottomMessage({@required BuildContext context,String id}){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Form(
              key: formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your name here',
                    labelText: "Author",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },controller: authorFieldController,
                ),
                TextFormField(maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: 'Enter your comment here',
//                          labelText: "Comment",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },controller: textFieldController,
                ),
                RaisedButton(
                  onPressed: () {
                    _addComment(context: context,id: id);
                  },
                  child: Text("Comment"),
                )
              ]));
        });
  }
 _addComment({@required BuildContext context,String id}){
   if (formKey.currentState.validate()) {

     var newComment = json.encode(Comment(
         id: Uuid().v4().toString(),
         authorName: authorFieldController.text,
         creationTime: DateTime.now().toString(),
         text: textFieldController.text,isParent: id==null)
         .toJson());
    var message = addCommentCommand + splitter + newComment + ((id==null)?"":splitter+id);
     channel.sink.add(message);
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



}