import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/model/app_user.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/collections.dart';

class Space extends AppUser {
  late String name;
  late String description;
  late Map<String, List<Map<String, String>>> calendar;
  late Map<String, String?> contacts;
  late Map<String, dynamic> elements;
  late GeoPoint location;
  late int minPrice;
  late int maxPrice;
  late String priceDescription;
  late int numberOfPeople;
  late Person owner;
  late double size;
  late double ocijena;
  late int numberOfReviews;
  late List<String> tags;

  Space(String id) : super(id);

  Future<Space?> get self => FirebaseFirestore.instance.collection(Collections.space).doc(id).get().then((value) => getData(value));

  Space? getData(DocumentSnapshot data) {
    if (!data.exists) return null;
    try {
      name = data["name"];
      description = data["description"];
      calendar = (data["calendar"] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, (value as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String))).toList()
//            [{'a':'a'}],
              ));
      contacts = (data["contacts"] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String?));
      elements = data["elements"];
      location = data["location"] as GeoPoint;
      minPrice = data["minPrice"];
      maxPrice = data["maxPrice"];
      //priceDescription = data["priceDescription"];
      numberOfPeople = data["numberOfPeople"];
      owner = Person(data["owner"]);
      size = data["size"];
      ocijena = data["ocijena"];
      numberOfReviews = data["numberOfReviews"];
      tags = (data["tags"] as List<dynamic>).map((e) => e as String).toList();
    } catch (e) {
      return null;
    }
    return this;
  }

  static Future<void> createSpace(Space space) async {
    await FirebaseFirestore.instance.collection(Collections.space).doc(space.id).set({
      "name": space.name,
    });
  }

  static Future<List<Space>> getSpaces() async {
    try {
      return await FirebaseFirestore.instance
          .collection(Collections.space)
          .get()
          .then((value) => value.docs.map((e) => Space(e.id).getData(e)!).toList());
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
