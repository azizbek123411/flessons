import 'package:app1/provider/todo/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoHome extends StatelessWidget {
  TodoHome({super.key});
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter Todo',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        todoProvider.addTodo(
                          textController.text,
                        );
                        textController.clear();
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoProvider.todos.length,
              itemBuilder: (context, index) {
                final todos = todoProvider.todos[index];
                return ListTile(
                  trailing: IconButton(
                    onPressed: () => todoProvider.removeTodo(index),
                    icon: Icon(
                      Icons.remove,
                    ),
                  ),
                  leading: Checkbox(
                    value: todos.isDone,
                    onChanged: (value) => todoProvider.toggleTode(index),
                  ),
                  title: Text(
                    todos.title,
                    style: TextStyle(
                      decoration:
                          todos.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
