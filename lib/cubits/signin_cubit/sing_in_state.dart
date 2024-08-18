part of 'sing_in_cubit.dart';

@immutable
sealed class SingInState {}

final class SingInInitial extends SingInState {}
final class SingInLoading extends SingInState {}
final class SingInSuccess extends SingInState {
  final UserCredential userCredential;

  SingInSuccess({required this.userCredential});
}
final class SingInException extends SingInState {
  final String message;

  SingInException({required this.message});
}
