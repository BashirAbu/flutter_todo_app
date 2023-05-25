import 'package:flutter/material.dart';

class TodoItem {
  TodoItem({required this.title, required this.subtitle});
  String? title;
  String? subtitle;
  bool done = false;
}

final TextEditingController subtitleTextController = TextEditingController();
final TextEditingController titleTextController = TextEditingController();
List<TodoItem> todoList = List<TodoItem>.empty(growable: true);
