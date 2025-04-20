import 'package:app1/riverpod/todo_river/service.dart';
import 'package:app1/riverpod/todo_river/todoriver_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterType { all, completed, uncompleted }

final filterProvider = StateProvider<FilterType>((ref) => FilterType.all);

class Todoriverscreen extends ConsumerWidget {
  Todoriverscreen({super.key});

  final filteredTodosProvider = Provider<List<TodoRiverModel>>((ref) {
    final filter = ref.watch(filterProvider);
    final todos = ref.watch(todoRiverProvider);
    switch (filter) {
      case FilterType.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case FilterType.uncompleted:
        return todos.where((todo) => !todo.isCompleted).toList();
      case FilterType.all:
      default:
        return todos;
    }
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodosProvider);
    final todoNotifier = ref.read(todoRiverProvider.notifier);
    final controller = TextEditingController();
    final editTitle = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('TodoRiver'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  ref.read(filterProvider.notifier).state = FilterType.all;
                },
                child: Text(
                  'All',
                  style: TextStyle(
                    color: ref.watch(filterProvider) == FilterType.all
                        ? const Color.fromARGB(255, 141, 20, 38)
                        : Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(filterProvider.notifier).state =
                      FilterType.completed;
                },
                child: Text(
                  'Completed',
                  style: TextStyle(
                    color: ref.read(filterProvider) == FilterType.completed
                        ? const Color.fromARGB(255, 141, 20, 38)
                        : Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(filterProvider.notifier).state =
                      FilterType.uncompleted;
                },
                child: Text(
                  'Uncompleted',
                  style: TextStyle(
                    color: ref.read(filterProvider) == FilterType.uncompleted
                        ? const Color.fromARGB(255, 141, 20, 38)
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
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
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Edit Todo'),
                            content: TextField(
                              controller: editTitle,
                              decoration:
                                  InputDecoration(hintText: 'Enter new title'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  todoNotifier.editTodo(
                                      todos[index].id, editTitle.text);
                                  Navigator.pop(context);
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        });
                  },
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
