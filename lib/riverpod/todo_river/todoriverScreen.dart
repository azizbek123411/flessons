import 'package:app1/riverpod/todo_river/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todoriverscreen extends ConsumerWidget {
  const Todoriverscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoRiverProvider);
    final todoNotifier = ref.watch(todoRiverProvider.notifier);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('TodoRiver'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      todoNotifier.addTodo(controller.text);
                      controller.clear();
                    }
                  },
                  icon: Icon(Icons.add),
                ),
                hintText: 'Enter Todo',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    todos[index].title,
                    style: TextStyle(
                      decoration: todos[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todos[index].isCompleted,
                    onChanged: (_) => todoNotifier.toggleTodo(todos[index].id),
                  ),
                  trailing: IconButton(
                    onPressed: () => todoNotifier.deleteTodo(todos[index].id),
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
