import 'package:bloc/bloc.dart';

/// 전역적으로 bloc 변경을 감지하는 옵저버이다
///
class CounterObserver extends BlocObserver {
  const CounterObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // 어떤 블락이 어떤 변화를 변화가 이루어졌는지 감지한다.
    // 해당 bloc / cubit 상관없이 동작한다.
    print('${bloc.runtimeType} $change');
  }
}
