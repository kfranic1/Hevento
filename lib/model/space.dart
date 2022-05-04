import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/collections.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';

class Space {
  String id;
  late String name;
  late String description;
  late Map<DateTime, String> calendar;
  late Map<String, String?> contacts;
  late Map<String, dynamic> elements;
  late GeoPoint location;
  late int minPrice;
  late int maxPrice;
  late String priceDescription;
  late int numberOfPeople;
  late Person owner;
  late double size;
  late double rating;
  late int numberOfReviews;
  late List<String> tags;

  Space(this.id);

  Future<Space?> get self => FirebaseFirestore.instance.collection(Collections.space).doc(id).get().then((value) => getData(value));

  Space? getData(DocumentSnapshot data) {
    if (!data.exists) return null;
    try {
      name = data["name"];
      description = data["description"];
      calendar = (data["calendar"] as Map<dynamic, dynamic>).map((key, value) => MapEntry(DateTime.parse(key), value as String));
      //(value as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String))).toList()));
      contacts = (data["contacts"] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String?));
      elements = data["elements"];
      location = data["location"] as GeoPoint;
      minPrice = data["minPrice"];
      maxPrice = data["maxPrice"];
      priceDescription = data["priceDescription"];
      numberOfPeople = data["numberOfPeople"];
      owner = Person(data["owner"]);
      size = data["size"];
      rating = data["rating"];
      numberOfReviews = data["numberOfReviews"];
      tags = (data["tags"] as List<dynamic>).map((e) => e as String).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
    return this;
  }

  bool pass(Filter filter) {
    if (filter.maxPrice < minPrice * 1.1) return false;
    if (filter.numberOfPeople > numberOfPeople * 1.1) return false;
    return true;
  }

  Future addEvent(DateTime dateTime, String description) async {
    try {
      calendar[dateTime.trim()] = description;
      await FirebaseFirestore.instance
          .collection(Collections.space)
          .doc(id)
          .update({"calendar": calendar.map((key, value) => MapEntry(key.toString(), value))});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> createSpace(Person appUser, Space space) async {
    try {
      await FirebaseFirestore.instance.collection(Collections.space).add({
        "name": space.name,
        "description": space.description,
        "calendar": <String, List<Map<String, String>>>{},
        "contacts": space.contacts,
        "elements": space.elements,
        "location": const GeoPoint(0, 0),
        "minPrice": space.minPrice,
        "maxPrice": space.maxPrice,
        "priceDescription": space.priceDescription,
        "numberOfPeople": space.numberOfPeople,
        "owner": space.owner.id,
        "size": space.size,
        "rating": space.rating,
        "numberOfReviews": 0,
        "tags": space.tags,
        "mySpaces": [space.id],
      }).then((space) async => await appUser.addSpace(space.id));
    } catch (e) {
      print(e.toString());
    }
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
