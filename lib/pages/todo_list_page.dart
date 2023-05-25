import 'package:flutter/material.dart';
import '../global.dart';
class TodoListPage extends StatefulWidget {
  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State<TodoListPage> {
  bool _validateTitleTextField = false;
  void clearList() {
    setState(() {
      todoList.clear();
    });
  }

  void onSubmitButtonPressed() {
    if (titleTextController.text.isEmpty) {
      setState(() {
        _validateTitleTextField = true;
      });
      return;
    }
    setState(() {
      _validateTitleTextField = false;
      todoList.add(TodoItem(
          title: titleTextController.text,
          subtitle: subtitleTextController.text));
      titleTextController.text = "";
      subtitleTextController.text = "";
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("To-do Entry Submitted!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-do List"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {
            setState(() {
              todoList.sort((a, b) => a.title
                  .toString()
                  .toLowerCase()
                  .compareTo(b.title.toString().toLowerCase()));
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                todoList.clear();
              });
            },
          )
        ],
      ),
      body: Column(children: [
        todoList.isEmpty
            ? const Center(
                child: Text(
                    "You do not have any task available, press the + button ot add one",
                    textAlign: TextAlign.center))
            : Expanded(
                child: ListView.builder(
                itemBuilder: (context, index) {
                  return TodoListViewItem(listIndex: index);
                },
                itemCount: todoList.length,
              ))
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("New Task"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                            controller: titleTextController,
                            decoration: InputDecoration(labelText: "title")),
                        TextField(
                            controller: subtitleTextController,
                            decoration: InputDecoration(labelText: "subtitle")),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 16, right: 4, left: 4, bottom: 8),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("cancel"))),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 16, right: 4, left: 4, bottom: 8),
                                  child: ElevatedButton(
                                      onPressed: onSubmitButtonPressed,
                                      child: const Text("submit"))),
                            ]),
                      ],
                    ),
                  );
                });
          },
          child: const Text("+")),
    );
  }
}

class TodoListViewItem extends StatefulWidget {
  final int? listIndex;
  const TodoListViewItem({Key? key, required this.listIndex}) : super(key: key);
  @override
  TodoListViewItemState createState() => TodoListViewItemState();
}

class TodoListViewItemState extends State<TodoListViewItem> {
  void onCheckboxChange(bool? change) {
    setState(() {
      todoList[widget.listIndex!].done = !change!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Checkbox(
                value: todoList[widget.listIndex!].done,
                onChanged: (bool? change) {
                  setState(() {
                    todoList[widget.listIndex!].done = change!;
                  });
                }),
            Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todoList[widget.listIndex!].title!,
                        style: TextStyle(
                            decoration: todoList[widget.listIndex!].done
                                ? TextDecoration.lineThrough
                                : null)),
                    Text(todoList[widget.listIndex!].subtitle!,
                        style: TextStyle(
                            decoration: todoList[widget.listIndex!].done
                                ? TextDecoration.lineThrough
                                : null))
                  ],
                ))
          ],
        ));
  }
}
