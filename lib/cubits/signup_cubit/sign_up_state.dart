part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpSuccess extends SignUpState {
  final UserCredential userCredential;

  SignUpSuccess({required this.userCredential});
}
final class SignUpException extends SignUpState {
  final String message;

  SignUpException({required this.message});
}
