import 'package:app1/provider/counter/provider.dart';
import 'package:app1/provider/get.dart';
import 'package:app1/provider/jsonplaceholder_api/api_home.dart';
import 'package:app1/provider/todo/todo_home.dart';
import 'package:app1/provider/todo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'provider/jsonplaceholder_api/api_provider.dart';
import 'provider/todo/todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('counterBox');
  await Hive.openBox<TodoModel>('todos');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Counter(
            Hive.box<int>('counterBox'),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
        ChangeNotifierProvider(
          create:(context)=>UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApiService(),
        ),
      ],
      child: const MyApp(),
    ),
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
      // home: const HomePage(),
      // home: TodoHome(),
      // home: ApiHome(),
      home: Homee(),
    );
  }
}
