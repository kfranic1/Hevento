import 'package:firebase_auth/firebase_auth.dart';
import 'package:hevento/model/person.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<Person?> get authStateChanges => _auth.authStateChanges().map((user) {
        if (user == null || user.isAnonymous) return null;
        return Person(user.uid);
      });

  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password, Person? person) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        if (person == null) throw Exception("Person not provided");
          person.id = value.user!.uid;
          await Person.createPerson(person);
      });
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
