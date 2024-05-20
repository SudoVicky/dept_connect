import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String email;
  final String user;
  final String dept;

  AuthenticationAuthenticated(
      {required this.email, required this.user, required this.dept});
  @override
  List<Object?> get props => [email, user, dept];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
