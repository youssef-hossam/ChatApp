import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../Pages/chat_page.dart';
import '../../helper/snakbar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  login({
    required String email,
    required String pass,
  }) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      // Navigator.pushNamed(
      //   context, ChatPage.id,
      //   // arguments: email.text
      // );

      // ShowSnakbar(context, 'success');
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.message ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        // AwesomeDialog(
        //   context: context,
        //   dialogType: DialogType.error,
        //   headerAnimationLoop: true,
        //   animType: AnimType.bottomSlide,
        //   title: 'Invalid email or password!',
        //   reverseBtnOrder: true,
        //   btnOkOnPress: () {},
        //   btnCancelOnPress: () {},
        //   desc: 'Please try again.',
        // ).show();
      }
      emit(LoginFailure(errorMeessage: 'Invalid email or password!'));
    } catch (e) {
      emit(LoginFailure(errorMeessage: e.toString()));
    }
  }
}
