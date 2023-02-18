import 'package:bloc_practice/timer/bloc/timer_bloc.dart';
import 'package:bloc_practice/timer/ticker.dart';
import 'package:bloc_practice/timer/view/background.dart';
import 'package:bloc_practice/timer/view/timer_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: const _TimerView(),
    );
  }
}

class _TimerView extends StatelessWidget {
  const _TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time is ticking"),
      ),
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                  child: Center(
                    child: _TimerText(),
                  )),
              TimerAction()
            ],
          )
        ],
      ),
    );
  }
}

class _TimerText extends StatelessWidget {
  const _TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int duration =
        context.select((TimerBloc bloc) => bloc.state.duration);
    final minuteStr = (duration / 60).floor().toString().padLeft(2, '0');
    final secondStr = (duration % 60).toString().padLeft(2, '0');

    return Text(
      "$minuteStr : $secondStr",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
