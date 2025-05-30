class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  String createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.id = '',
    this.isDone = false,
  });
}