import 'package:app1/riverpod/future/future_model.dart';
import 'package:app1/riverpod/future/future_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ui extends ConsumerWidget {
  const Ui({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(futureProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Provider'),
      ),
      body: posts.when(
        data: ((data) => ListView.builder(
              itemBuilder: (context, index) {
                final post = data[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormPage(
                                model: post,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                          onPressed: () async {
                            await ref
                                .watch(serviceProvider)
                                .deleteFuture(post.id);
                            ref.invalidate(futureProvider);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                );
              },
            )),
        error: (e, st) {
          return Center(
            child: Text("E:$e,,,,,,, ST:$st"),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FormPage(),
          ),
        );
      }),
    );
  }
}

class FormPage extends ConsumerStatefulWidget {
  FutureModel? model;
  FormPage({super.key, this.model});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends ConsumerState<FormPage> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController = TextEditingController(text: widget.model?.title ?? '');
    bodyController = TextEditingController(text: widget.model?.body ?? '');
    super.initState();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final post = FutureModel(
      id: widget.model!.id,
      title: titleController.text,
      body: bodyController.text,
    );

    if (widget.model == null) {
      await ref.read(serviceProvider).createFuture(post);
    } else {
      await ref.read(serviceProvider).updateFuture(post);
    }

    ref.invalidate(futureProvider);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.model != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Post' : 'Create Post')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'title'),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),
              TextFormField(
                controller: bodyController,
                decoration: InputDecoration(hintText: 'body'),
                validator: (value) => value!.isEmpty ? 'Enter body' : null,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _submit(),
                child: Text(isEditing ? 'Update' : "Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
