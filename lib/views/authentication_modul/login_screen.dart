import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/cubits/signup_cubit/sign_up_cubit.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/views/dashboard/home_screen.dart';
import '../../cubits/signin_cubit/sing_in_cubit.dart';
import '../custom_methods/custom_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late SingInCubit singInCubit;
  late SignUpCubit signUpCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCubits();
  }

  initCubits() {
    singInCubit = context.read<SingInCubit>();
    signUpCubit = context.read<SignUpCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SingInCubit, SingInState>(
            listener: (context, signInState) {
              if (signInState is SingInSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (
                      context) => const UserProfilePage()),
                );
              } else if (signInState is SingInException) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(signInState.message.toString()),
                    duration: const Duration(milliseconds: 300),
                  ),
                );
                signUpCubit.callSignUp(password: _passwordController.text,
                    email: _emailController.text);
              }
            },
          ),
          BlocListener<SignUpCubit, SignUpState>(
            listener: (context, signUpState) {
              if (signUpState is SignUpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed Up Successfully')),
                );
                singInCubit.callSignIn(
                  email: _emailController.text,
                  password: _passwordController.text,);
              } else if (signUpState is SignUpException) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(signUpState.message.toString())),
                );
              }
            },
          ),
        ],
        child: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/Login.png'),
              )),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Text(
                  'Log in!',
                  style: GoogleFonts.poppins(
                    fontSize: 41.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.pinkColor,
                  ),
                ),
                SizedBox(
                  height: 120.h,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 16.h,),
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      // Color of the border when the field is enabled
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      // Color of the border when the field is focused
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    border: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      // Color of the border in general
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    // Basic email regex pattern
                    final emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 16.h,),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: Colors.white),
                    // Border customization
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      // Color of the border when the field is enabled
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      // Color of the border when the field is focused
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                    border: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      // Color of the border in general
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 3) {
                      return 'Please provide a valid password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 60.h,
                ),
                const SizedBox(height: 70),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      singInCubit.callSignIn(
                        email: _emailController.text,
                        password: _passwordController.text,);
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, singUpState) {
                        return BlocBuilder<SingInCubit, SingInState>(
                          builder: (context, state) {
                            return (state is SingInLoading
                            || singUpState is SignUpLoading)
                                ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.pinkColor,
                                ))
                                : const CustomButton();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

