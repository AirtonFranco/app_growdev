import 'dart:convert';

class CardModel {
  int? id;
  String? title;
  String? content;
  CardModel({
    this.id,
    this.title,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) =>
      CardModel.fromMap(json.decode(source));
}
