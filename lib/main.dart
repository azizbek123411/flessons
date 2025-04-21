import 'package:app1/provider/todo/todo_model.dart';
import 'package:app1/riverpod/future/ui.dart';
import 'package:app1/riverpod/riverapi/post_page.dart';
import 'package:app1/riverpod/todo_river/todoriverScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('counterBox');
  await Hive.openBox<TodoModel>('todos');
  runApp(
    ProviderScope(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),

      // home: CounterHome(),
      // home: Todoriverscreen(),
      home: PostPage(),
      // home: Ui(),
    );
  }
}