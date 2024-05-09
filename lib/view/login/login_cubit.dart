import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/view/login/login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void login(String username, String password) {
    // Implement login logic here
    // For simplicity, let's assume successful login for any non-empty credentials
    if (username.isNotEmpty && password.isNotEmpty) {
      emit(AuthSuccess(username: username));
    } else {
      emit(const AuthError(message: "Invalid credentials"));
    }
  }
  
  void signup(String username, String password) {
    // Implement signup logic here
    // For simplicity, let's assume successful signup for any non-empty credentials
    if (username.isNotEmpty && password.isNotEmpty) {
      emit(AuthSuccess(username: username));
    } else {
      emit(const AuthError(message: "Invalid credentials"));
    }
  }
}
 