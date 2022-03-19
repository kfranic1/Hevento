import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/helpers/pair.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/collections.dart';

class Space extends AppUser {
  late String name;
  late Map<DateTime, List<Pair<String, String>>> calendar;
  late Map<String, String> contacts;
  late Map<String, dynamic> elements;
  late GeoPoint location;
  late int minPrice;
  late int maxPrice;
  late String priceDescription;
  late int numberOfPeople;
  late Person owner;
  late double size;

  Space(String id) : super(id);

  @override
  Stream<Space?> get self => FirebaseFirestore.instance.collection(Collections.space).doc(id).snapshots().map((event) => getData(event));

  Space? getData(DocumentSnapshot data) {
    if (!data.exists) return null;
    name = data["name"];
    return this;
  }

  static Future<void> createSpace(Space space) async {
    await FirebaseFirestore.instance.collection(Collections.space).doc(space.id).set({
      "name": space.name,
    });
  }
}
