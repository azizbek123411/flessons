import 'package:app1/provider/counter/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Counter>(context);
    return Scaffold(
      body: Center(
        child: Text(provider.counter.toString()),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => provider.increment()),
    );
  }
}
