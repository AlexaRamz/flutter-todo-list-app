import 'package:todo_list_app/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;
  String userId;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.id = '',
    this.isDone = false,
    this.userId = '',
  });

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
      userId: json['userId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'title': title,
      'description': description,
      'id': id,
      'isDone': isDone,
      'userId': userId,
    };
  }
}