import 'package:firebase_auth/firebase_auth.dart';
import 'package:hevento/model/space.dart';

class AuthService {
  final FirebaseAuth _auth;
  //UserType _userType = UserType.unknown;

  AuthService(this._auth);

  Stream<Space?> get authStateChanges => _auth.authStateChanges().map((event) => event == null ? null : Space(event.uid));

  Future<String> signInSpace(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUpSpace(String email, String password, String spaceName) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async => await Space.createSpace(value.user!.uid, spaceName));
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUpPerson(String email, String password, String firstName, String lastName) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }
}
