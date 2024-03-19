import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:schoolar_chat/Pages/chat_page.dart';
import 'package:schoolar_chat/Pages/register_page.dart';
import 'package:schoolar_chat/consttants.dart';
import 'package:schoolar_chat/widgets/custom_button.dart';
import 'package:schoolar_chat/widgets/custom_textfield.dart';

import '../helper/snakbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'loginpage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool isloading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
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
                        "Login",
                        style: TextStyle(fontSize: 26.sp, color: Colors.white),
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
                        text: "Login",
                        ontap: () async {
                          if (formstate.currentState!.validate()) {
                            try {
                              isloading = true;
                              setState(() {});
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text, password: pass.text);
                              Navigator.pushNamed(context, ChatPage.id,
                                  arguments: email.text);

                              // ShowSnakbar(context, 'success');
                            } on FirebaseAuthException catch (e) {
                              if (e.message ==
                                  "The supplied auth credential is incorrect, malformed or has expired.") {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  headerAnimationLoop: true,
                                  animType: AnimType.bottomSlide,
                                  title: 'Invalid email or password!',
                                  reverseBtnOrder: true,
                                  btnOkOnPress: () {},
                                  btnCancelOnPress: () {},
                                  desc: 'Please try again.',
                                ).show();
                              }
                            } catch (e) {
                              ShowSnakbar(context, '${e.toString()}');
                            }
                          }
                          isloading = false;
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ,",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          "Register",
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
  }
}
