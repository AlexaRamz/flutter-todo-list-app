import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/widgets/todo_widget.dart';
import '../provider/todos.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No todos.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return TodoWidget(todo: todo);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 8);
      },
    );
  }
}
