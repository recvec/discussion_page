import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable(nullable: true)
class Comment   {

  final String id;
  final String authorName;
  final String text;
  final String creationTime;
  int state;
  List<Comment> nestedComments;

  Comment({@required this.id, @required this.authorName, @required this.text, @required this.creationTime, this.state,
      this.nestedComments});
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

}
