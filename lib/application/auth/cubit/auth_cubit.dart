import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_1/infrastructure/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

// ! State Management
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthRepository _authRepository = AuthRepository();

  // Trigger when user clicked login button
  void signInUser(String email, String password) async {
    // To inform the system is loading when we clicked login button
    emit(AuthLoading()); // Emit is function in cubit
    try {
      String? _data = await _authRepository.signInUserWithEmailAndPassword(
          email: email, password: password);
      // To inform the system when login success
      emit(AuthLoginSuccess(_data!));
    } catch (e) {
      // To inform the system when login error / failed
      emit(AuthError(e.toString()));
    }
  }
}
