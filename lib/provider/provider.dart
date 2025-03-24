import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Counter extends ChangeNotifier{
  final Box<int> _box;
  int _counter;
  Counter(this._box):_counter=_box.get('counter',defaultValue: 0)!;
  
  int get counter => _counter;

void increment(){
  _counter++;
  _box.put('counter', _counter);
  notifyListeners();
}
}