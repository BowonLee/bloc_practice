part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._(
      {this.status = AuthenticationStatus.unknown, this.user = User.empty});

  final AuthenticationStatus status;
  final User user;

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user) :
        this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthState.unauthenticated() :
        this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];

}
