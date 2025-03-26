import 'package:app1/provider/todo/todo_model.dart';
import 'package:flutter/material.dart';

enum FilterOption { all, completed, pending }

class TodoProvider extends ChangeNotifier {
  FilterOption _filter = FilterOption.all;
  List<TodoModel> get filteredTodos {
    switch (_filter) {
      case FilterOption.completed:
        return todos.where((todo) => todo.isDone).toList();
      case FilterOption.pending:
        return todos.where((todo) => !todo.isDone).toList();
      default:
        return todos;
    }
  }


  void setFilter(FilterOption filter){
    _filter=filter;
    notifyListeners();
  }

  List<TodoModel> _todos=[];
  List<TodoModel> get todos => _todos;

  void addTodo(String title) {
    _todos.add(TodoModel(title: title));
    notifyListeners();
  }

  void toggleTode(int index) {
    final todo = _todos[index];
    todo.isDone = !todo.isDone;
  
      notifyListeners();
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void editTodo(String newTitle, int index) {
    final todo = _todos[index];
    todo.title = newTitle;
    
    notifyListeners();
    }
}
