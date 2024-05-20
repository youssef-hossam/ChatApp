import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
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

  register({
    required String email,
    required String pass,
  }) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(RegisterSuccess());
      // Navigator.pushNamed(context, ChatPage.id, arguments: email.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        emit(RegisterFaliure(
            errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        emit(RegisterFaliure(
            errorMessage: 'The account already exists for that email.'));
        // ShowSnakbar(context, "The account already exists for that email");
      }
    } catch (e) {
      // print(e);
      emit(RegisterFaliure(errorMessage: e.toString()));
    }
  }
}
