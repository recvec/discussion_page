import 'dart:convert';
import 'dart:math';

import 'package:discussion_page/provider/discussion_provider.dart';
import 'package:discussion_page/ui/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'model/comment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiscussionProvider>(
      create: (context) => DiscussionProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: DiscussionPage(),
      ),
    );
  }
}

class DiscussionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscussionProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          StreamBuilder(
            stream: provider.channelStream,
            builder: (context, snapshot) {
              var response = snapshot.data;
              var count;
              if (response == null) {
                count = 0;
              } else {
                count = List.from(json.decode(response)).length;
              }
              return Text(count.toString());
            },
          ),
          SizedBox(
            width: 40,
          ),
          Text("Space Comments")
        ],
      )),
      body: StreamBuilder(
        stream: provider.channelStream,
        builder: (context, snapshot) {
          var response = snapshot.data;
          print(response);
          if (response != null) {
//          List<Comment> comments = json.decode(response).map((x)=>Comment.fromJson(x))  ;
            List<Comment> comments = List<Comment>.from(
                json.decode(response).map((x) => Comment.fromJson(x)));
            comments.sort((a, b) => b.creationTime.compareTo(a.creationTime));
            return Card(
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      if (comments[index].isParent)
                        return PostItem(comments[index]);
                      else
                        return Container();
                    }),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text("2020"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.showBottomMessage(context: context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
