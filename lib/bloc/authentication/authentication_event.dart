import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String user;

  AuthenticationLoginRequested(this.email, this.password, this.user);

  @override
  List<Object?> get props => [email, password, user];
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String userId;

  AuthenticationLoggedIn(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
