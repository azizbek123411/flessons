import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'future_provider.dart';

class Ui extends ConsumerWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Future provider'),
      ),
      body: future.when(
        data: ((data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){
            return ListTile(
              title: Text(data[index].name),
            );
          });
        }),
        error: (e, _) => Center(
          child: Text("Xatolik:$e"),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
