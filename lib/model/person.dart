import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/collections.dart';

class Person {
  String id;
  late String name;
  late String username;
  late String email;
  late List<Space> mySpaces;

  Person(this.id);

  Stream<Person?> get self => FirebaseFirestore.instance.collection(Collections.person).doc(id).snapshots().map((data) => parseData(data));

  Person? parseData(DocumentSnapshot data) {
    if (data.data() == null) return null;
    name = data["name"];
    username = data["username"];
    email = data["email"];
    mySpaces = (data["mySpaces"] as List<dynamic>).map((e) => Space((e as String))).toList();
    return this;
  }

  Future addSpace(String spaceId)async{
    mySpaces.add(Space(spaceId));
    FirebaseFirestore.instance.collection(Collections.person).doc(id).update({"mySpaces": mySpaces.map((e) => e.id).toList()});
  }

  static Future createPerson(Person person) async {
    await FirebaseFirestore.instance.collection(Collections.person).doc(person.id).set({
      "name": person.name,
      "email": person.email,
      "username": person.username,
      "mySpaces": List<String>.empty(),
    });
  }
}
