import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}
class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  const LoginEvent({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}
class SignupEvent extends AuthEvent {
  final String username;
  final String password;
  const SignupEvent({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}
// States
abstract class AuthState extends Equatable {
  const AuthState();
}
class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthSuccess extends AuthState {
  final String username;
  const AuthSuccess({required this.username});
  @override
  List<Object?> get props => [username];
}
class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
  @override
  List<Object?> get props => [message];
}