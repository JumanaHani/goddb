import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF9C2CF3), // #9C2CF3
                    Color(0xFF3A49F9), // #3A49F9
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(),
            ),
            Positioned(
              top: 225.h,
              left: 42.w,
              child: Container(
                width: 600.w,
                height: 900.h,
                padding: EdgeInsets.all(24.w),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/LogIn');
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 24,
                          )),
                      Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Login",
                              style: Theme.of(context).textTheme.labelLarge,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Sign Up tap
                                  Navigator.pushNamed(context, '/LogIn');
                                  print("Sign Up tapped!");
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 552.w,
                        height: 600.h,
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            } else if (state is AuthSuccess) {
                              Navigator.pushReplacementNamed(
                                  context, '/HomePage');
                            }
                          },
                          builder: (context, state) {
                            return Form(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 400.h,
                                    child: ListView(
                                      children: [
                                        Text('Full Name'),
                                        TextField(
                                          controller: nameController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Color(0xFF000000),
                                              ),
                                          decoration: const InputDecoration(
                                            hintText: 'enter your FullName',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text('Email'),
                                        TextField(
                                          controller: emailController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Color(0xFF000000),
                                              ),
                                          decoration: const InputDecoration(
                                            hintText: 'enter your email',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text('Set Password'),
                                        BlocBuilder<AuthCubit, AuthState>(
                                          builder: (context, state) {
                                            bool obscure = true;
                                            if (state is AuthInitial) {
                                              obscure = state.obscurePassword;
                                            }
                                            return TextField(
                                              controller: passwordController,
                                              obscureText: obscure,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Color(0xFF000000),
                                                  ),
                                              decoration: InputDecoration(
                                                hintText: 'enter your password',
                                                suffixIcon: IconButton(
                                                  icon: Icon(obscure
                                                      ? Icons.visibility_off
                                                      : Icons.visibility),
                                                  onPressed: () {
                                                    context
                                                        .read<AuthCubit>()
                                                        .togglePasswordVisibility();
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 50,),
                                  Container(
                                    width: 552.w,
                                    child: state is AuthLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ElevatedButton(
                                            onPressed: () {
                                              final email =
                                                  emailController.text.trim();
                                              final password =
                                                  passwordController.text
                                                      .trim();
                                              final name =
                                                  nameController.text.trim();

                                              if (email.isEmpty ||
                                                  password.isEmpty ||
                                                  name.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          "Please fill all fields")),
                                                );
                                                return;
                                              }

                                              context
                                                  .read<AuthCubit>()
                                                  .signUpWithEmail(
                                                      email, password,name);
                                            },
                                            child: const Text('Sign Up'),
                                          ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
