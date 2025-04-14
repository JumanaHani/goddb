import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().loadSavedCredentials().then((credentials) {
      emailController.text = credentials['email'] ?? '';
      passwordController.text = credentials['password'] ?? '';
      setState(() {
        rememberMe = credentials['email'] != null;
      });
    });
  }

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
                padding: EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Don’t have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context).textTheme.labelLarge,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle Sign Up tap
                                Navigator.pushNamed(context, '/SignUp');
                                print("Sign Up tapped!");
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
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
                            child: ListView(
                              children: [
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
                                Text('Password'),
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets
                                            .zero, // removes padding around the tile
                                        visualDensity: VisualDensity(
                                            horizontal:
                                                -4), // makes leading/title closer
                                        title: Text('Remember me',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                        leading: Checkbox(
                                          value: rememberMe,
                                          onChanged: (val) {
                                            setState(() {
                                              rememberMe = val!;
                                            });
                                          },
                                          side: BorderSide(
                                              color: Color(0xff6C7278)),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final email = emailController.text;
                                        if (email.isNotEmpty) {
                                          context
                                              .read<AuthCubit>()
                                              .resetPassword(email);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Password reset link sent.")),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Please enter your email first.")),
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Forgot Password ?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 552.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/HomePage');
                          context.read<AuthCubit>().loginWithEmail(
                                emailController.text,
                                passwordController.text,
                                rememberMe: rememberMe,
                              );
                        },
                        child: Text('Log in'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
