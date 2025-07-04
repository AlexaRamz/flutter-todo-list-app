import 'package:flutter/cupertino.dart';

import '../api/firebase_api.dart';
import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos {
    return _todos.where((todo) => todo.isDone == false).toList();
  }

  List <Todo> get todosCompleted {
    return _todos.where((todo) => todo.isDone == true).toList();
  }

  void addTodo(Todo todo) {
    FirebaseApi.createTodo(todo);
  }

  void removeTodo(Todo todo) {
    FirebaseApi.deleteTodo(todo);
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }

  void setTodos(List<Todo>? todos) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (todos != null) {
        _todos = todos;

        notifyListeners();
      }
    });
  }
}