import 'package:app1/provider/todo/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoHome extends StatelessWidget {
  TodoHome({super.key});
  final textController = TextEditingController();

  void _editTodoDialog(BuildContext context, int index) {
    final tdProvider = Provider.of<TodoProvider>(context, listen: false);
    final controller =
        TextEditingController(text: tdProvider.todos[index].title);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    tdProvider.editTodo(controller.text, index);
                    Navigator.pop(context);
                  },
                  child: Text('Save')),
            ],
            title: Text('Edit todos'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'New title'),
            ),
          );
        });
  }

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
          PopupMenuButton<FilterOption>(
              onSelected: (filter) {
                todoProvider.setFilter(filter);
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: FilterOption.all,
                      child: Text('All'),
                    ),
                    PopupMenuItem(
                      value: FilterOption.completed,
                      child: Text('Completed'),
                    ),
                    PopupMenuItem(
                      value: FilterOption.pending,
                      child: Text('Pending'),
                    ),
                  ]),
          Expanded(
            child: ListView.builder(
              itemCount: todoProvider.filteredTodos.length,
              itemBuilder: (context, index) {
                final todos = todoProvider.filteredTodos[index];
                return ListTile(
                  onTap: () => _editTodoDialog(context, index),
                  trailing: IconButton(
                    onPressed: () => context.read<TodoProvider>().removeTodo(index),
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
