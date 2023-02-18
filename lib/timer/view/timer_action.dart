import 'package:bloc_practice/timer/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerAction extends StatelessWidget {
  const TimerAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerBloc = context.read<TimerBloc>();

    return BlocBuilder<TimerBloc, TimerState>(
      // 상태의변화가 일어나는 경우 다시 빌드한다.
      buildWhen: (prev, current) => prev.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                onPressed: () {
                  timerBloc.add(TimerStarted(duration: state.duration));
                },
                child: const Icon(Icons.play_arrow),
              )
            ],
            if (state is TimerRunProgress) ...[
              FloatingActionButton(
                onPressed: () {
                  timerBloc.add(const TimerPaused());
                },
                child: const Icon(Icons.pause),
              ),
              FloatingActionButton(
                onPressed: () {
                  timerBloc.add(const TimerReset());
                },
                child: const Icon(Icons.replay),
              )
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                onPressed: () {
                  timerBloc.add(TimerResumed());
                },
                child: const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: () {
                  timerBloc.add(TimerReset());
                },
                child: const Icon(Icons.replay),
              )
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
                onPressed: () {
                  timerBloc.add(TimerReset());
                },
                child: const Icon(Icons.replay),
              )
            ],
          ],
        );
      },
    );
  }
}
