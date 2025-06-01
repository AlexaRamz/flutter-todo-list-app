import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_list_app/utils.dart';
import '../model/todo.dart';

class FirebaseApi {
  static Future<String?> createTodo(Todo todo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final docTodo = FirebaseFirestore.instance.collection('todo').doc();

      todo.id = docTodo.id;
      todo.userId = uid;

      await docTodo.set(todo.toJson());

      return docTodo.id;
    }
    else {
      if (kDebugMode) {
        print('User not authenticated. Cannot add todo.');
      }
      return null;
    }
  }

  static Stream<List<Todo>> readTodos() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    return FirebaseFirestore.instance
        .collection('todo')
        .where('userId', isEqualTo: user.uid)
        .orderBy(TodoField.createdTime, descending: true)
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson));
  }

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async{
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}