import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/api/firebase_api.dart';
import 'package:todo_list_app/main.dart';

import '../model/todo.dart';
import '../provider/todos.dart';
import '../widgets/add_todo_dialog.dart';
import '../widgets/completed_list_widget.dart';
import '../widgets/todo_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyApp.title,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withValues(alpha: 0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>> (
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              }
              else {
                final todos = snapshot.data;

                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddTodoDialogWidget();
          },
          barrierDismissible: true,
        ),
        child: Icon(Icons.add),
      ),
      //   Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       FirebaseAuth.instance.signOut().then((value) {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
      //       });
      //     },
      //     child: Text("Logout"),
      //   ),
      // ),
    );
  }
}

Widget buildText(String text) => Center(
  child: Text(
    text,
    style: TextStyle(fontSize: 24, color: Colors.white),
  ),
);
