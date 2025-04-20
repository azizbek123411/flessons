import 'package:app1/riverpod/todo_river/todoriver_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';







class TodoriverProvider extends StateNotifier<List<TodoRiverModel>>{
  TodoriverProvider():super([]);

  void addTodo(String title){
    final newTodo=TodoRiverModel(id: UniqueKey().toString(), title: title);
    state=[
      ...state,
      newTodo,
    ];
  }


void toggle(String id){
  state=[
    for(final todo in state)
     if(todo.id==id)
      todo.copyWith(isCompleted: !todo.isCompleted)
      else
       todo,
  ];
}

  void editTodo(String id,String newTitle){
    state=state.map((todo){
      if(todo.id==id){
        return todo.copyWith(title:newTitle);
      }
      return todo;  
    }).toList();
  }

  void toggleTodo(String id){
    state=state.map((todo){
      if(todo.id==id){
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }

  void deleteTodo(String id){
    state=state.where((todo)=>todo.id != id).toList();
  }
}