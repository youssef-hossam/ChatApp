// ignore_for_file: must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:schoolar_chat/Pages/chat_page.dart';
import 'package:schoolar_chat/blocs/auth/auth_bloc.dart';

import '../consttants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  static String id = "registerpage";

  RegisterPage({super.key});

  final TextEditingController email = TextEditingController();

  final TextEditingController pass = TextEditingController();

  final GlobalKey<FormState> formstate = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isloading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email.text);
          isloading = false;
        } else if (state is RegisterFaliure) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            headerAnimationLoop: true,
            animType: AnimType.bottomSlide,
            title: state.errorMessage,
            reverseBtnOrder: true,
            btnOkOnPress: () {},
            btnCancelOnPress: () {},
            desc: 'Please try again.',
          ).show();
          isloading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: ModalProgressHUD(
            inAsyncCall: isloading,
            child: Form(
              key: formstate,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 70.h,
                          ),
                          Image.asset('assets/images/scholar.png'),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Schoolar Chat",
                            style: TextStyle(
                                fontSize: 32.sp,
                                color: Colors.white,
                                fontFamily: 'Pacifico'),
                          )
                        ],
                      ),
                    ]),
                    SizedBox(
                      height: 70.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style:
                                TextStyle(fontSize: 26.sp, color: Colors.white),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          CustomTextFormField(
                            obscure: false,
                            controller: email,
                            text: 'Email',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomTextFormField(
                            obscure: true,
                            controller: pass,
                            text: "Password",
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomButtton(
                            text: "Register",
                            ontap: () async {
                              if (formstate.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    RegisterEvent(
                                        email: email.text.trim(),
                                        password: pass.text.trim()));
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "alraedy have an account,",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              " Login",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
