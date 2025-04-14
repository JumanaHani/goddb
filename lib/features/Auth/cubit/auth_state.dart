abstract class AuthState {}

class AuthInitial extends AuthState {
  final bool obscurePassword;
  AuthInitial({this.obscurePassword = true});
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
