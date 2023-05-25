import 'package:flutter/material.dart';
import '../globals.dart';
class TodoEntryPage extends StatefulWidget {
  @override
  TodoEntryPageState createState() => TodoEntryPageState();
}

class TodoEntryPageState extends State<TodoEntryPage>
    with AutomaticKeepAliveClientMixin<TodoEntryPage> {
  @override
  bool get wantKeepAlive => true;
  bool _validateTitleTextField = false;
  String? title;

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
    super.build(context);
    // Widget template comes here
    return Scaffold(
        appBar: AppBar(
          title: const Text("To-do Entry"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "Enter your to-do",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Title",
                        errorText: _validateTitleTextField
                            ? "Please enter some text"
                            : null),
                    controller: titleTextController,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Subtitle"),
                    controller: subtitleTextController,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: onSubmitButtonPressed,
                          child: const Text("Submit")))
                ],
              ),
            )));
  }
}