import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/services/collections.dart';

class Person {
  String id;
  late String name;
  late String username;
  late String email;

  Person(this.id);

  Stream<Person?> get self => FirebaseFirestore.instance.collection(Collections.person).doc(id).snapshots().map((data) => parseData(data));

  Person? parseData(DocumentSnapshot data) {
    if (data.data() == null) return null;
    name = data["name"];
    username = data["username"];
    email = data["email"];
    return this;
  }

  static Future createPerson(Person person) async {
    await FirebaseFirestore.instance.collection(Collections.person).doc(person.id).set({
      "name": person.name,
      "email": person.email,
      "username": person.username,
    });
  }
}
