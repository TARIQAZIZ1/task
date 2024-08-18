import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubits/signup_cubit/sign_up_cubit.dart';
import '../cubits/signin_cubit/sing_in_cubit.dart';
import '../data/repositories/auth_repository.dart';

var providers = [
  BlocProvider<SingInCubit>(
    create: (BuildContext context) => SingInCubit(AuthRepo()),
  ),
  BlocProvider<SignUpCubit>(
    create: (BuildContext context) => SignUpCubit(AuthRepo()),
  ),
];