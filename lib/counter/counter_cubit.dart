import 'package:bloc/bloc.dart';



/// 즘감 기능의 cubit
class CounterCubit extends Cubit<int> {
  CounterCubit(): super(100);

  /// Add 1 to the current state.
  void increment() => emit(state + 1);

  /// Subtract 1 from the current state.
  void decrement() => emit(state - 1);
}
