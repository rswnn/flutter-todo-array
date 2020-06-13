import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: new TodoList(),
      theme: ThemeData(fontFamily: 'Rubik'),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todoItems = [];
  void addItem(String task) {
    setState(() {
      todoItems.add(task);
    });
  }

  void removeItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  void editItem(int index, String items) {
    setState(() {
      todoItems.replaceRange(index, index + 1, [items]);
      Navigator.of(context).pop();
    });
  }

  void promptOfItem(int index, String todoText) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Apa Kamu yakin ingin menghapus ?'),
            actions: <Widget>[
              new IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pop();
                    editTodoScreen(index, todoText);
                  }),
              new IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    removeItem(index);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  Widget buildTodoItem(String todoText, int index) {
    return new Card(
      child: new ListTile(
        title: new Text(
          todoText,
          style: TextStyle(fontFamily: 'Rubik'),
        ),
        trailing: new IconButton(
          onPressed: () {
            promptOfItem(index, todoText);
          },
          icon: new Icon(Icons.delete),
        ),
      ),
    );
  }

  Widget buildTodoList() {
    return new ListView.builder(itemBuilder: (context, index) {
      if (index < todoItems.length) {
        return buildTodoItem(todoItems[index], index);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
      ),
      body: buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Task',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Tambah task baru'),
        ),
        body: new TextField(
          autofocus: true,
          onSubmitted: (val) {
            addItem(val);
            Navigator.pop(context);
          },
          decoration: new InputDecoration(
              hintText: "tulis sesuatu ...",
              contentPadding: const EdgeInsets.all(16.0)),
        ),
      );
    }));
  }

  void editTodoScreen(int index, String item) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Edit Task'),
        ),
        body: new TextField(
          autofocus: true,
          controller: new TextEditingController(text: item),
          onSubmitted: (res) {
            editItem(index, res);
          },
          decoration:
              new InputDecoration(contentPadding: const EdgeInsets.all(19.0)),
        ),
      );
    }));
  }
}
