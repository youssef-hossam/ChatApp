import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

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
