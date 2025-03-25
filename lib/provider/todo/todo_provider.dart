import 'package:app1/provider/todo/todo_model.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier{

final List _todos=[];
List get todos=> _todos;


void addTodo(String title){
  _todos.add(TodoModel(title: title));
  notifyListeners();
}
void toggleTode(int index){
  _todos[index].isDone=!_todos[index].isDone;
  notifyListeners();
}

void removeTodo(int index){
  _todos.removeAt(index);
  notifyListeners();
}

}