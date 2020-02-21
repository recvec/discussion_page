import 'package:discussion_page/ui/post_item.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: DiscussionPage(),
    );
  }
}

class DiscussionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                 children: <Widget>[Text("Something")],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
