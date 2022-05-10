import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/collections.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<Person?> get authStateChanges => _auth.authStateChanges().map((user) {
        if (user == null || user.isAnonymous) return null;
        return Person(user.uid);
      });

  Future<String?> signIn({required String username, required String password}) async {
    try {
      String? email =
          await FirebaseFirestore.instance.collection(Collections.person).where("username", isEqualTo: username).limit(1).get().then((value) {
        if (value.docs.isEmpty) return null;
        return value.docs.first["email"] as String;
      });
      if (email == null) return "Pogrešno korisničko ime ili lozinka";
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException {
      return "Pogrešno korisničko ime ili lozinka";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp({required Person person, required String password}) async {
    try {
      bool ok = await FirebaseFirestore.instance
          .collection(Collections.person)
          .where("username", isEqualTo: person.username)
          .limit(1)
          .get()
          .then((value) => value.docs.isEmpty);
      if (!ok) return "Korisničko ime je već zauzeto";
      await _auth.createUserWithEmailAndPassword(email: person.email, password: password).then((value) async {
        person.id = value.user!.uid;
        await Person.createPerson(person);
      });
      return null;
    } on FirebaseAuthException {
      return "Pogrešno korisničko ime ili lozinka";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
