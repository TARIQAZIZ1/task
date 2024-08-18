import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'sing_in_state.dart';

class SingInCubit extends Cubit<SingInState> {
  final AuthRepository authRepository;
  SingInCubit(this.authRepository) : super(SingInInitial());
  callSignIn({required String password, required String email,}) async{
    try{
      emit(SingInLoading());
      var apiResponse = await authRepository.signIn(email: email, password: password);
      if(apiResponse is UserCredential){
        emit(SingInSuccess(userCredential: apiResponse));
      }else{
        emit(SingInException(message: apiResponse.toString()));
      }
    }
    catch(e){
      emit(SingInException(message: e.toString()));
    }
  }
}
