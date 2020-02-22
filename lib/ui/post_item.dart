import 'package:discussion_page/model/comment.dart';
import 'package:discussion_page/provider/discussion_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostItem extends StatelessWidget {
  final Comment comment;
  final f = new DateFormat('dd-MM-yyyy hh:mm:ss');
  final TextEditingController editTextFieldController = TextEditingController();

  PostItem(this.comment);

  ValueNotifier<bool> _isEditMode = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscussionProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
              SizedBox(
                width: 15,
              ),
              Text(f.format(DateTime.parse(comment.creationTime)))
            ],
          ),
          ValueListenableBuilder<bool>(
              valueListenable: _isEditMode,
              builder: (context, data, _) {
                editTextFieldController.text = comment.text;
                return data
                    ? TextFormField(
                        controller: editTextFieldController,
                      )
                    : Text(comment.text);
              }),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text("Сomment"),
                onPressed: () {
                  provider.showBottomMessage(context: context, id: comment.id);
                },
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _isEditMode,
                  builder: (context, data, _) => data
                      ? IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () async {
                            await provider.updateComment(
                                comment.id, editTextFieldController.text);
                            _isEditMode.value = false;
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.mode_edit),
                          onPressed: () {
                            _isEditMode.value = true;
                          },
                        )),
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
                  comment.nestedComments
                      .sort((a, b) => b.creationTime.compareTo(a.creationTime));
                  return PostItem(comment.nestedComments[index]);
                }),
          ),
        ],
      ),
    );
  }
}
