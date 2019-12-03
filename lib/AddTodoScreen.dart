import 'package:app_todo_list/modal/Todo.dart';
import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTodoScreenState();
  }
}

class AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();

  void _goBackListTodo() {
    Todo todo = new Todo(
        title: title.text, description: description.text, isDone: false);
    Navigator.pop(context, todo);
  }

  Widget _buidTextInput(String title, TextField textInput) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(color: Colors.blue, fontSize: 18.0),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            margin: const EdgeInsets.only(top: 12.0),
            child: textInput,
          )
        ],
      ),
    );
  }

  Widget _buttonAdd() {
    return Container(
        margin: const EdgeInsets.only(top: 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
              onPressed: _goBackListTodo,
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Add Todo', style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _buidTextInput(
                "Title",
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                      hintText: "Title todo", border: OutlineInputBorder()),
                )),
            _buidTextInput(
                "Description",
                TextField(
                  controller: description,
                  decoration: InputDecoration(
                      hintText: "Description ...",
                      border: OutlineInputBorder()),
                  maxLines: null,
                )),
            _buttonAdd()
          ],
        ),
      ),
    );
  }
}
