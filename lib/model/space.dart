import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/services/collections.dart';

class Space {
  String id;
  late String name;

  Space(this.id);

  Stream<Space?> get self => FirebaseFirestore.instance.collection(Collections.spaces).doc(id).snapshots().map((event) => getData(event));

  Space? getData(DocumentSnapshot data) {
    if (!data.exists) return null;
    name = data["name"];
    return this;
  }

  static Future<void> createSpace(String uid, String name) async {
    await FirebaseFirestore.instance.collection(Collections.spaces).doc(uid).set({
      "name": name,
    });
  }
}
