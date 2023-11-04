// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_bottom.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/show_snack_bar.dart';
import 'chat_screen.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;
    bool obsecure=true;
  bool isLoading=false;

GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey ,
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 80),
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
                        'Register',
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
                      suffixIconButton: GestureDetector(child: Icon(Icons.email,color: Colors.white,),),
                      validate: (String? data){
                        if(data!.isEmpty) {
                          return 'Email must be addes';
                        } else if(!data!.contains('@')) {
                          return 'there was an error with your email';
                        } else if(!data!.endsWith('.com')) {
                          return 'this not an email';
                        }

                      },
                      onChanged: (data) {
                        email = data;
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
                      validate: (String? data){
                        if(data!.isEmpty) {
                          return 'Password Must be added';
                        } else if(data!.length<8) {
                          return 'Password must have 8 digits at least';
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
                       text:'Register ',
                      ontap: () async {
                        if (formKey.currentState!.validate()) {

                          setState(() {
                            isLoading=true;
                          });
                          try {

                            await registerMethod();
                            showSnackBar(context, message: 'Registered Successfully', color: Colors.green,);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  ChatPage(email: email!,)));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(context,color: Colors.red,message: 'Very weak Password, try again',);
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(context,color: Colors.red,message: 'Email is already exists',);
                            }
                          }catch(e){
                            showSnackBar(context, message: e.toString(), color: Colors.red);
                          }

                          setState(() {
                            isLoading=false;
                          });
                        }

                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ? ',
                            style: TextStyle(color: Colors.white)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login Now',
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

  Future<void> registerMethod() async {
    var auth = FirebaseAuth.instance;
    UserCredential user =
        await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
