import 'package:bloc/bloc.dart';



/// 즘감 기능의 cubit
/// Cubit은 단일 state의 변경을 처리한다. 단순한 동작에 적합하며 사용이 쉽다.
/// 여느 상태관리와 같이 super에 초기값이 들어간다.
class CounterCubit extends Cubit<int> {
  CounterCubit(): super(100);

  /// Add 1 to the current state.
  void increment() => emit(state + 1);

  /// Subtract 1 from the current state.
  void decrement() => emit(state - 1);
}
