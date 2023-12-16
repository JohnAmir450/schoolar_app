// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../widgets/show_snack_bar.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitial());

  Future<void> loginUser(context,
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user-not-found'));
      } else if (e.code == 'ERROR_WRONG_PASSWORD') {
        emit(LoginFailure(errorMessage: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'Something went worng'));
    }
  }

  bool isVisible = true;
  IconData icon = Icons.visibility;
  passwordVisibility() {
    isVisible = !isVisible;
    icon = isVisible ? Icons.visibility : Icons.visibility_off;
    emit(PasswordVisibilityState());
  }

  registerUser(context,
      {required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'Very weak Password, try again'));
        showSnackBar(
          context,
          color: Colors.red,
          message: 'Very weak Password, try again',
        );
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'Email is already exists'));

        showSnackBar(
          context,
          color: Colors.red,
          message: 'Email is already exists',
        );
      }
    }
  }
}
