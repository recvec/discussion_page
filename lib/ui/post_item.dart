import 'package:discussion_page/model/comment.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
Comment comment;

  PostItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(comment.state.toString()),
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () {},
            ),
            Text(comment.authorName),
            Text(comment.creationTime)
          ],
        ),
        Text(
            comment.text),
        Row(
          children: <Widget>[
            FlatButton(
              child: Text("Сomment"),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        ),
//        if (index == 0)
//          Padding(padding: const EdgeInsets.only(left: 40),
//              child: PostItem(1))

      ],
    );
  }
}
