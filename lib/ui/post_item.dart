import 'package:discussion_page/model/comment.dart';
import 'package:discussion_page/provider/discussion_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostItem extends StatelessWidget {
  Comment comment;
  final f = new DateFormat('dd-MM-yyyy hh:mm:ss');
  PostItem(this.comment);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscussionProvider>(context, listen: false);

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
              onPressed: () {
                provider.likeComment(comment.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () {
                provider.dislikeComment(comment.id);
              },
            ),
            Text(comment.authorName),
            Text(f.format(DateTime.parse(comment.creationTime)))
          ],
        ),
        Text(comment.text),
        Row(
          children: <Widget>[
            FlatButton(
              child: Text("Сomment"),
              onPressed: () {
                provider.showBottomMessage(context: context, id: comment.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                provider.deleteComment(comment.id);
              },
            ),
          ],
        ),
         Padding(
           padding: const EdgeInsets.only(left: 30),
           child: ListView.builder(

               physics: ClampingScrollPhysics(),
               shrinkWrap: true,
              itemCount: comment.nestedComments.length,
              itemBuilder: (context, index) {
                 comment.nestedComments.sort((a,b)=>b.creationTime.compareTo(a.creationTime));
                return PostItem(comment.nestedComments[index]);
              }),
         ),
      ],
    );
  }
}
