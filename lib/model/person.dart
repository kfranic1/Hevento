import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/collections.dart';

class Person extends AppUser {
  late String name;
  late String lastname;
  late String username;
  late String email;
  late List<Space> mySpaces;

  Person(String id) : super(id);

  @override
  Stream<Person?> get self => FirebaseFirestore.instance.collection(Collections.person).doc(id).snapshots().map((data) => parseData(data));

  Person parseData(DocumentSnapshot data) {
    name = data["name"];
    lastname = data["lastname"];
    username = data["username"];
    email = data["email"];
    mySpaces = (data["mySpaces"] as List<dynamic>).map((e) => Space((e as DocumentReference).id)).toList();
    return this;
  }

  static Future<void> createPerson(Person person) async {
    await FirebaseFirestore.instance.collection(Collections.person).doc(person.id).set({
      "name": person.name,
      "lastname": '', //person.lastname,
      "email": '', //person.email,
      "username": '', //person.username,
      "mySpaces": [],
    });
  }
}
