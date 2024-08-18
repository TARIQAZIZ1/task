import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/auth_repository.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit(this.authRepository) : super(SignUpInitial());
  callSignUp({required String password, required String email,}) async{
    try{
      emit(SignUpLoading());
      var apiResponse = await authRepository.signUp(email: email, password: password);
      if(apiResponse is UserCredential){
        emit(SignUpSuccess(userCredential: apiResponse));
      }else{
        emit(SignUpException(message: apiResponse.toString()));
      }
    }
    catch(e){
      emit(SignUpException(message: e.toString()));
    }
  }
}
