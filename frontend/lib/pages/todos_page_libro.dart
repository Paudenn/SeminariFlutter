import 'package:flutter/material.dart';
import 'package:julia_app/models/todoService.dart';
import 'package:julia_app/models/todo_model.dart';
import 'package:julia_app/models/todolist_bloc.dart';
import 'package:julia_app/widgets/todo_libro.dart';

class TodosPageBook extends StatefulWidget {
  const TodosPageBook({Key? key}) : super(key: key);

  @override
  State<TodosPageBook> createState() => _TodosPageBookState();
}

class _TodosPageBookState extends State<TodosPageBook> {
  TodoService service = TodoService();
  TextEditingController textController =
      TextEditingController(text: 'Enter a book');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('http')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder<List<TodoModel>?>(
              future: service.getTodos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Todo> todos = [];
                  snapshot.data!.forEach((todo) => todos.add(Todo(
                        todo: todo,
                        refreshUi: () {
                          setState(() {});
                        },
                      )));
                  return Column(children: [...todos]);
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter a book',
                errorText:
                    (textController.text.isEmpty) ? 'Text is empty' : null,
              ),
              onSubmitted: (value) async {
                if (textController.text.isNotEmpty) {
                  await service.postTodo(TodoModel(title: textController.text));
                  textController.text = 'Enter a book';
                  setState(() {});
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
