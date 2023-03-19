import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_practice/login/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
    _authenticationRepository = AuthenticationRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({Key? key}) : super(key: key);

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  @overrides
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
