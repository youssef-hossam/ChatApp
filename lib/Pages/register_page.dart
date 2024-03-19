import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:schoolar_chat/Pages/chat_page.dart';

import '../consttants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../helper/snakbar.dart';

class RegisterPage extends StatefulWidget {
  static String id = "registerpage";

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();

  bool isloading = false;
  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        text: "Register",
                        ontap: () async {
                          if (formstate.currentState!.validate()) {
                            isloading = true;
                            try {
                              setState(() {});
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email.text,
                                password: pass.text,
                              );
                              Navigator.pushNamed(context, ChatPage.id,
                                  arguments: email.text);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                                ShowSnakbar(context,
                                    "The account already exists for that email");
                              }
                            } catch (e) {
                              print(e);
                            }
                            isloading = false;
                            setState(() {});
                          }
                          // or
                          // AwesomeDialog(
                          //   context: context,
                          //   dialogType: DialogType.error,
                          //   headerAnimationLoop: true,
                          //   animType: AnimType.bottomSlide,
                          //   title: 'The account already exists for that email.',
                          //   reverseBtnOrder: true,
                          //   btnOkOnPress: () {},
                          //   btnCancelOnPress: () {},
                          //   desc: 'Enter a diffrent email please,',
                          // ).show();
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
  }
}
