import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterHome extends ConsumerWidget {
  const CounterHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider=ref.watch(counterRiverProvider);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {
          if(provider>0){
            ref.read(counterRiverProvider.notifier).state--;
          }
        },icon: Icon(Icons.remove),)
      ],),
      body: Center(
        child: 
          Text(provider.toString(),style: TextStyle(fontSize: 20),),
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        ref.read(counterRiverProvider.notifier).state++;
      }),
    );
  }
}

final counterRiverProvider=StateProvider<int>((ref)=>0);