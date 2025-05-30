import 'package:flutter/cupertino.dart';

import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now().toString(),
      title: 'Walk the Dog',
    ),
    Todo(
      createdTime: DateTime.now().toString(),
      title: 'Walk the Dog',
    ),
    Todo(
      createdTime: DateTime.now().toString(),
      title: 'Walk the Dog',
    ),
    Todo(
      createdTime: DateTime.now().toString(),
      title: 'Walk the Dog',
    ),
  ];

  List<Todo> get todos {
    return _todos.where((todo) => todo.isDone == false).toList();
  }
}