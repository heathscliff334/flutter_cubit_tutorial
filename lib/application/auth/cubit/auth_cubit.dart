import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_1/domain/auth/model/login_request.dart';
import 'package:flutter_cubit_1/domain/auth/model/login_response.dart';
import 'package:flutter_cubit_1/infrastructure/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

// ! State Management
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthRepository _authRepository = AuthRepository();

  // Trigger when user clicked login button
  void signInUser(LoginRequest loginRequest) async {
    // To inform the system is loading when we clicked login button
    emit(AuthLoading()); // Emit is function in cubit
    try {
      // print("Try from login");
      final _data = await _authRepository.signInUserWithEmailAndPassword(
          loginRequest: loginRequest);
      // To inform the system when login success
      _data.fold(
        (l) => emit(AuthError(l)), // ! if wrong
        (r) => emit(AuthLoginSuccess(r)), // ? if right
      );
    } catch (e) {
      // To inform the system when login error / failed
      print("Catch");
      emit(AuthError(e.toString()));
    }
  }
}
