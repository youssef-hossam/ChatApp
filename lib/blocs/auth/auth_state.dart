part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMeessage;
  LoginFailure({
    required this.errorMeessage,
  });
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFaliure extends AuthState {
  final String errorMessage;
  RegisterFaliure({
    required this.errorMessage,
  });
}
