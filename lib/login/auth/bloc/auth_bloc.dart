import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// 최초의 상태는 미설정ㄴㄴ알수 없음) 상태
///
///
///
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on((event, emit) => onAuthLogoutRequest);
    on((event, emit) => onAuthChange);

    /// 생성과 동시에 스트림을 구독해둔다. 해당 스트림이 변결될 경우 이벤트를 발행한다.
    _authStreamSubscription = _authRepository.status.listen((status) {
      add(_AuthChangedEvent(status));
    });
  }

  final AuthenticationRepository _authRepository;
  final UserRepository _userRepository;

  late StreamSubscription<AuthenticationStatus> _authStreamSubscription;

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }

  Future<void> onAuthChange(
      _AuthChangedEvent event, Emitter<AuthState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        return emit(const AuthState.unknown());

      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        emit(user != null
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated());
        break;
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
    }
  }

  Future<void> onAuthLogoutRequest(
      AuthLogoutRequest authLogoutRequest, Emitter<AuthState> emit) async {}

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
