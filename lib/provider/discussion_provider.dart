import 'package:flutter/material.dart';
import 'package:web_socket_channel/html.dart';

class DiscussionProvider extends ChangeNotifier{
  HtmlWebSocketChannel channel;
var channelStream;
  leaveComment({String id}){
      if(id==null){

      }
      else{

      }
  }

  DiscussionProvider(){
    channel = HtmlWebSocketChannel.connect("ws://localhost:37777");
    channelStream = channel.stream.asBroadcastStream();
    print("channel inited");
  }



}