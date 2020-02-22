// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as String,
    authorName: json['authorName'] as String,
    text: json['text'] as String,
    creationTime: json['creationTime'] as String,
    state: json['state'] as int,
    nestedComments: (json['nestedComments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'authorName': instance.authorName,
      'text': instance.text,
      'creationTime': instance.creationTime,
      'state': instance.state,
      'nestedComments': instance.nestedComments,
    };
