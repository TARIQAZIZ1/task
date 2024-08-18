import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository{
  Future signIn({required String email, required String password});
  Future signUp({required String email, required String password});
}
class AuthRepo extends AuthRepository{
  final _auth = FirebaseAuth.instance;

  @override
  Future signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }
  @override
  Future signUp({required String email, required String password,}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

}