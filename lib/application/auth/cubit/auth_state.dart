part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

// ? Auth state like a checkpoint, to inform the user the feedback of the process
class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;
  // ? call from consturctor
  AuthError(this.errorMessage);
}

class AuthLoginSuccess extends AuthState {
  // ? The data type is string (adjusts the data type like the variable in the infrastructure "Future<String>")
  final String dataLogin;
  AuthLoginSuccess(this.dataLogin);
}
