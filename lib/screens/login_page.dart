// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:schoolar_app/screens/chat_screen.dart';
import 'package:schoolar_app/screens/register_screeen.dart';
import 'package:schoolar_app/widgets/show_snack_bar.dart';
import '../widgets/custom_bottom.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

  bool isLoading = false;
  bool obsecure = true;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/scholar.png'),
                    const Text(
                      'Schoolar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      suffixIconButton: GestureDetector(child: Icon(Icons.email,color: Colors.white,)),
                      onChanged: (data) {
                        email = data;
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email must be added';
                        }
                      },
                      label: 'Email',
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      obsecure: obsecure,
                      suffixIconButton: obsecure
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  obsecure = !obsecure;
                                });
                              },
                              child: Icon(Icons.lock_outline,color: Colors.white,),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    obsecure = !obsecure;
                                  },
                                );
                              },
                              child: Icon(Icons.lock_open,color: Colors.white,),
                            ),
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password must be added';
                        }
                      },
                      onChanged: (data) {
                        password = data;
                      },
                      label: 'Password',
                      type: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomButtom(
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await loginMethod();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  email: email!,
                                ),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context,
                                  message:
                                      'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context,
                                  message:
                                      'The account already exists for that email.');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context,
                                  message:
                                      'Wrong password provided for that user.');
                            }
                          } catch (e) {
                            print(e.toString());
                            showSnackBar(context,
                                message: 'Something went Wrong');
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      text: 'Login ',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account ? ',
                            style: TextStyle(color: Colors.white)),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: const Text(
                              'Register Now',
                              style: TextStyle(color: Colors.lightBlue),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginMethod() async {
    var auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email!, password: password!);
  }
}
