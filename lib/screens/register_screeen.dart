// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:schoolar_app/screens/cubits/auth_cubit/auth_cubit.dart';
import '../widgets/custom_bottom.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/show_snack_bar.dart';
import 'chat_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;
  bool obsecure = true;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterFailure) {
          showSnackBar(context, message: state.errorMessage, color: Colors.red);
        } else if(state is RegisterSuccess ){
          showSnackBar(context, message: 'Success', color: Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                email: email!,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: formKey,
            child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 80),
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
                          suffixIconButton: GestureDetector(
                            child: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          validate: (String? data) {
                            if (data!.isEmpty) {
                              return 'Email must be addes';
                            } else if (!data.contains('@')) {
                              return 'there was an error with your email';
                            } else if (!data.endsWith('.com')) {
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
                           obsecure: BlocProvider.of<AuthCubit>(context).isVisible,
                          icon:BlocProvider.of<AuthCubit>(context).icon,
                          onPressed: (){
                            BlocProvider.of<AuthCubit>(context).passwordVisibility();
                          },
                          validate: (String? data) {
                            if (data!.isEmpty) {
                              return 'Password Must be added';
                            } else if (data.length < 8) {
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
                            text: 'Register ',
                            ontap: ()  {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context)
                                    .registerUser(context,
                                        email: email!, password: password!);
                              }
                            }),
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
      },
    );
  }
}
