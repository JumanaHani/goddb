import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  FirebaseAuth get _auth => FirebaseAuth.instance; // lazy getter

  AuthCubit() : super(AuthInitial());

  void togglePasswordVisibility() {
    if (state is AuthInitial) {
      final current = (state as AuthInitial).obscurePassword;
      emit(AuthInitial(obscurePassword: !current));
    }
  }

  Future<void> loginWithEmail(String email, String password,
      {bool rememberMe = false}) async {
    emit(AuthLoading());
    try {
      // Sign in the user



     UserCredential userCredential =    await _auth.signInWithEmailAndPassword(email: email, password: password);
    await _auth.currentUser?.updateDisplayName(userCredential.user?.displayName);
    await _auth.currentUser?.reload();//
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('password', password);
      }

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Login failed"));
    }
  }

  Future<void> signUpWithEmail(String email, String password,String name) async {
    emit(AuthLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(name);
      await _auth.currentUser?.reload();
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Signup failed"));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Failed to send reset email"));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    emit(AuthInitial());
  }

  Future<Map<String, String?>> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    return {'email': email, 'password': password};
  }
}
