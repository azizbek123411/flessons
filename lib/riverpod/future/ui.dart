import 'package:app1/riverpod/future/future_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'future_provider.dart';

class Ui extends ConsumerWidget {
  const Ui({super.key});
  void _addNote(BuildContext context, WidgetRef ref) async {
    final newNote = FutureModel(id: 0, title: 'New Note', body: 'Note body');
    final note = await ref.read(createFuture(newNote).future);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Note created: ${note.title}')),
    );
  }

  void _updateNote(
      BuildContext context, WidgetRef ref, FutureModel model) async {
    final updated = model.copyWith(title: 'Updated Title');
    final result = await ref.watch(editFuture(updated).future);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Note updated: ${result.title}')),
    );
  }

  void _deleteNote(BuildContext context, WidgetRef ref, int noteId) async {
    await ref.watch(deleteFuture(noteId).future);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Note deleted')),
    );
  }

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
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _updateNote(context, ref, data[index]),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            _deleteNote(context, ref, data[index].id),
                      ),
                    ],
                  ),
                );
              });
        }),
        error: (e, st) => Center(
          child: Text("Xatolik:$e st:$st"),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
