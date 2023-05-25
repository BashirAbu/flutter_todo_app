import 'package:flutter/material.dart';
import 'pages/todo_entry_page.dart';
import 'pages/todo_list_page.dart';
void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Todo List", home: MainPage());
  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  MainPageState createState() => MainPageState();
}


class MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _index = 0;
  final List<StatefulWidget> _pages = [TodoEntryPage(), TodoListPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _index = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (int index) {
            _pageController.jumpToPage(index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.login), label: "Entry"),
            NavigationDestination(icon: Icon(Icons.list), label: "List")
          ]),
    );
  }
}







