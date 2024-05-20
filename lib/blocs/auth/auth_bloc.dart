import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);

          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.message ==
              "The supplied auth credential is incorrect, malformed or has expired.") {}
          emit(LoginFailure(errorMeessage: 'Invalid email or password!'));
        } catch (e) {
          emit(LoginFailure(errorMeessage: e.toString()));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
    });
  }
}
