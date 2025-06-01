import 'package:flutter/cupertino.dart';

import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog',
    ),
  ];

  List<Todo> get todos {
    return _todos.where((todo) => todo.isDone == false).toList();
  }

  List <Todo> get todosCompleted {
    return _todos.where((todo) => todo.isDone == true).toList();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}