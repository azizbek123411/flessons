import 'package:app1/riverpod/todo_river/todoriver_model.dart';
import 'package:app1/riverpod/todo_river/todoriver_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoRiverProvider =
    StateNotifierProvider<TodoriverProvider, List<TodoRiverModel>>(
  (ref) => TodoriverProvider(),
);
