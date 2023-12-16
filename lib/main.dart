import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolar_app/screens/cubits/auth_cubit/auth_cubit.dart';
import 'package:schoolar_app/screens/login_page.dart';
import 'bloc_observer.dart';
import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: primaryColor,
        ),
        title: 'School Chat',
        home: LoginPage(),
      ),
    );
  }
}
