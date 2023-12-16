// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:schoolar_app/screens/chat_screen.dart';
import 'package:schoolar_app/screens/register_screeen.dart';
import 'package:schoolar_app/widgets/show_snack_bar.dart';
import '../widgets/custom_bottom.dart';
import '../widgets/custom_text_field.dart';
import 'cubits/auth_cubit/auth_cubit.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});
  String? email, password;

   bool isLoading = false;
 

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          showSnackBar(context, message: 'Success',color: Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                email: email!,
              ),
            ),
          );
        } else if (state is LoginFailure) {
          showSnackBar(context, message: state.errorMessage, color: Colors.red);
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
                          suffixIconButton: GestureDetector(
                              child: const Icon(
                            Icons.email,
                            color: Colors.white,
                          )),
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
                          obsecure: BlocProvider.of<AuthCubit>(context).isVisible,
                          icon:BlocProvider.of<AuthCubit>(context).icon,
                          onPressed: (){
                            BlocProvider.of<AuthCubit>(context).passwordVisibility();
                          },
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
                          ontap: ()  {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).loginUser(
                                  context,
                                  email: email!,
                                  password: password!);
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
                                          builder: (context) =>
                                              const RegisterPage()));
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
      },
    );
  }
}
