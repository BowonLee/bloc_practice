

part of 'timer_bloc.dart';

abstract class TimerState extends Equatable{
  const TimerState(this.duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState{
  const TimerInitial(super.duration);

  @override
  String toString() => 'Time Init duration $duration ';
}

class TimerRunPause extends TimerState {
 const TimerRunPause(super.duration);

 @override
 String toString() => 'Time run pause duration $duration ';
}

class TimerRunProgress extends TimerState {
  const TimerRunProgress(super.duration);

  @override
  String toString() => 'Time run progress duration $duration ';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
