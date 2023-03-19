part of 'auth_bloc.dart';

/// 인증처리 이벤트
/// 인증요청
/// 인증 상태 변환
abstract class AuthEvent {
  const AuthEvent();
}

class _AuthChangedEvent extends AuthEvent {
  final AuthenticationStatus status;

  const _AuthChangedEvent(this.status);
}

class AuthLogoutRequest extends AuthEvent {}
