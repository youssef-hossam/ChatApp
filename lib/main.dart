import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolar_chat/Pages/chat_page.dart';
import 'package:schoolar_chat/Pages/register_page.dart';
import 'package:schoolar_chat/blocs/auth/auth_bloc.dart';
import 'package:schoolar_chat/cubits/auth/auth_cubit.dart';
import 'package:schoolar_chat/cubits/chat/chat_cubit.dart';

import 'Pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        splitScreenMode: true,
        minTextAdapt: true,
        child: MaterialApp(
          initialRoute: FirebaseAuth.instance.currentUser != null
              ? ChatPage.id
              : LoginPage.id,
          routes: {
            LoginPage.id: (context) => LoginPage(),
            RegisterPage.id: (context) => RegisterPage(),
            ChatPage.id: (context) => ChatPage(),
          },
        ),
      ),
    );
  }
}
