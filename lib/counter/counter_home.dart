import 'package:bloc_practice/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CounterHome extends StatelessWidget {
  const CounterHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=> CounterCubit(),
      child: MaterialApp(home: _CounterView()),
    );
  }
}

class _CounterView extends StatelessWidget {
  const _CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CounterCubit, int>(builder: (context, state) {

          return Text('$state');
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            onPressed: () {
            context.read<CounterCubit>().increment();
          }, child: Icon(Icons.add),),
          SizedBox(height: 10,),
          FloatingActionButton(onPressed: () {
            context.read<CounterCubit>().decrement();
          }, child: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
