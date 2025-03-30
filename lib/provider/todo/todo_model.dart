import 'package:hive_flutter/hive_flutter.dart';

class TodoModel extends HiveObject {
  String title;

  bool isDone;
  TodoModel({
    required this.title,
    this.isDone = false,
  });
}
