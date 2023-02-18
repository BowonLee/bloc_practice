import 'package:bloc/bloc.dart';
import 'package:bloc_practice/counter/counter_obsever.dart';
import 'package:bloc_practice/timer/view/timer_home.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = const CounterObserver();
  runApp(const TimerHome());
}
