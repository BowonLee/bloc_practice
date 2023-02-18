import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

/// bloc의 설정은 다음과 같은 단계로 진행된다.
///
/// 1. 시작값을 셋팅한다.
/// 2. 생성자에 이벤트 핸들러를 등록한다.
/// 3. 이벤트 핸들러의 정의는 내부 메서드를 통해 정의한다.
/// bloc< 이벤트 , 상태 >

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final Ticker _ticker;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStart);
    on<_TimerTicked>(_onTicked);
    on<TimerReset>(_onReset);
    on<TimerPaused>(_onPause);
    on<TimerResumed>(_onResumed);
  }

  // 시간 변경에 따른 이벤트
  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();

    return super.close();
  }

  void _onStart(TimerStarted state, Emitter<TimerState> emitter) {
    /// 이벤트 시작 시 로딩부터 보여준다.
    /// 이벤트 시작 시 기존 이벤트를 취소시킨다. (단일 이벤트)
    emit(TimerRunProgress(state.duration));

    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: state.duration).listen((duration) {
      add(_TimerTicked(duration: duration));
    });
  }

  void _onPause(TimerPaused state, Emitter<TimerState> emitter) {
    if (state is TimerRunProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause((state as TimerRunPause).duration));
    }
  }

  void _onResumed(TimerResumed state, Emitter<TimerState> emitter) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunProgress((state as TimerRunPause).duration));
    }
  }

  void _onReset(TimerReset state, Emitter<TimerState> emitter) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  void _onTicked(_TimerTicked state, Emitter<TimerState> emitter) {
    emit(state.duration > 0
        ? TimerRunProgress(state.duration)
        : const TimerRunComplete());
  }
}
