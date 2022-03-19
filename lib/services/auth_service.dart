import 'package:firebase_auth/firebase_auth.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/enums/user_type.dart';

class AuthService {
  final FirebaseAuth _auth;
  UserType? userType;

  AuthService(this._auth);

  Stream<AppUser?> get authStateChanges => _auth.authStateChanges().map((user) {
        if (user == null || user.isAnonymous) return null;
        if (userType == UserType.person) return Person(user.uid);
        return Space(user.uid);
      });

  Future<String> signIn(String email, String password, UserType userType) async {
    try {
      this.userType = userType;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password, UserType userType, {Person? person, Space? space}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        if (userType == UserType.person) {
          if (person == null) throw Exception("Person not provided");
          person.id = value.user!.uid;
          await Person.createPerson(person);
        } else {
          if (space == null) throw Exception("Space not provided");
          space.id = value.user!.uid;
          await Space.createSpace(space);
        }
      });
      this.userType = userType;
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
      userType = null;
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      return e.toString();
    }
  }
}
