import 'package:app_todo_list/AddTodoScreen.dart';
import 'package:app_todo_list/DetailScreen.dart';
import 'package:app_todo_list/modal/Todo.dart';
import "package:flutter/material.dart";

class TodoListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TodoListScreenState();
  }
}

class TodoListScreenState extends State<TodoListScreen> {
  var list_todos = new List<Todo>();
  final Set<Todo> _done = Set<Todo>();

  void _goToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoScreen()));
    if (result == null) return;
    setState(() {
      list_todos.add(result);
    });
  }

  AlertDialog dialog(BuildContext context, @required Todo todo) {
    return AlertDialog(
      title: Text("Thông báo"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text("Bạn có chắc chắn muốn xóa ...")],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            setState(() {
              list_todos.remove(todo);
            });
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget _buildRow(Todo todo) {
    final isDone = _done.contains(todo);
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
                fontSize: 16.0,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          leading: IconButton(
            icon:
                Icon(isDone ? Icons.check_box : Icons.check_box_outline_blank),
            onPressed: () {
              setState(() {
                isDone ? _done.remove(todo) : _done.add(todo);
              });
            },
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          todo: todo,
                        )));
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => dialog(context, todo));
            // setState(() {
            //   list_todos.remove(todo);
            // });
          },
        ),
        Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("TodoList")),
      body: list_todos.length <= 0
          ? Center(
              child: Text(
                "Hi, Welcome to Flutter!",
                style: TextStyle(color: Colors.blueAccent, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return _buildRow(list_todos[index]);
              },
              itemCount: list_todos.length,
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: () => _goToAddScreen(context),
      ),
    );
  }
}
