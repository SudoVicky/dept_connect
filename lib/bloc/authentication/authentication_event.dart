import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String user;

  const AuthenticationLoginRequested(this.email, this.password, this.user);

  @override
  List<Object?> get props => [email, password, user];
}

class AuthenticationLocalLoginRequested extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {
  const AuthenticationLoggedOut();

  @override
  List<Object?> get props => [];
}
