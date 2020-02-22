import 'package:discussion_page/provider/discussion_provider.dart';
import 'package:discussion_page/ui/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/post.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscussionProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Space comments 5"),
      ),
      body: Card(
        child: PostItem(0),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text("2020"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.channel.sink.add(Post("sd","ds","ds",43));
          print("Sended");
//          showModalBottomSheet(
//              context: context,
//              builder: (context) {
//                return Form(
//                    key: _formKey,
//                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: <Widget>[
//                      TextFormField(
//                        decoration: const InputDecoration(
//                          icon: Icon(Icons.person),
//                          hintText: 'Enter your name here',
//                          labelText: "Author",
//                        ),
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
//                      ),
//                      TextFormField(maxLines: 8,
//                        decoration: const InputDecoration(
//                          hintText: 'Enter your comment here',
////                          labelText: "Comment",
//                        ),
//                        validator: (value) {
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
//                      ),
//                      RaisedButton(
//                        onPressed: () {
////                          if (_formKey.currentState.validate()) {
////                            print("Sended");
////                          }
//
//                        },
//                        child: Text("Comment"),
//                      )
//                    ]));
//              });
        },
        child: Icon(Icons.add),
      ),
    );
  }



}
