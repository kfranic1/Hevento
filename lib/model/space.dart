import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/collections.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';
import 'package:image_picker/image_picker.dart';

class Space {
  String id;
  late String name;
  late String description;
  late String address;
  late Map<DateTime, String> calendar;
  Map<String, String?> contacts = {
    "phone": null,
    "email": null,
    "facebook": null,
    "instagram": null,
    "website": null,
  };
  Map<String, bool> elements = {
    "drinks": false,
    "food": false,
    "waiter": false,
    "security": false,
    "music": false,
    "smoking": false,
    "specialEffects": false,
  };
  Map<String, int?> price = {
    "Monday": null,
    "Tuesday": null,
    "Wednesday": null,
    "Thursday": null,
    "Friday": null,
    "Saturday": null,
    "Sunday": null,
  };
  late GeoPoint location;
  late int numberOfPeople;
  late Person owner;
  late double totalScore;
  late int numberOfReviews;
  late List<String>? tags;

  int get minPrice =>
      price.values
          .where((element) => element != null)
          .fold<int?>(null, (previousValue, element) => previousValue == null || element! < previousValue ? element : previousValue) ??
      0;
  int get maxPrice =>
      price.values
          .where((element) => element != null)
          .fold<int?>(null, (previousValue, element) => previousValue == null || element! > previousValue ? element : previousValue) ??
      0;

  bool get singlePrice => minPrice == maxPrice;

  double get rating => totalScore / max(numberOfReviews, 1);

  Space(this.id);

  Future<Space?> get self => FirebaseFirestore.instance.collection(Collections.space).doc(id).get().then((value) => getData(value));

  Space? getData(DocumentSnapshot data) {
    if (!data.exists) return null;
    try {
      name = data["name"];
      description = data["description"];
      address = data["address"];
      calendar = (data["calendar"] as Map<dynamic, dynamic>).map((key, value) => MapEntry(DateTime.parse(key), value as String));
      //(value as List<dynamic>).map((e) => (e as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String))).toList()));
      contacts = (data["contacts"] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as String?));
      elements = (data["elements"] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as bool));
      location = data["location"] as GeoPoint;
      numberOfPeople = data["numberOfPeople"];
      owner = Person(data["owner"]);
      totalScore = data["totalScore"];
      numberOfReviews = data["numberOfReviews"];
      tags = data["tags"] == null ? null : (data["tags"] as List<dynamic>).map((e) => e as String).toList();
      price = (data["price"] as Map<String, dynamic>).map((key, value) => MapEntry(key, value == null ? null : value as int));
    } catch (e) {
      print(e.toString());
      return null;
    }
    return this;
  }

  bool pass(Filter filter, {DateTime? day}) {
    if (filter.price < maxPrice * 1.1) return false;
    if (numberOfPeople * 1.5 > filter.numberOfPeople && filter.numberOfPeople > numberOfPeople * 0.9) return false;
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

  Future updateSpace() async {}

  Future addReview(int? rating, {int? oldRating, bool newReview = true}) async {
    try {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot doc = await transaction.get(FirebaseFirestore.instance.collection(Collections.space).doc(id));
        transaction.update(FirebaseFirestore.instance.collection(Collections.space).doc(id), {
          "totalScore": doc["totalScore"] + (rating ?? 0) - (oldRating ?? 0),
          "numberOfReviews": doc["numberOfReviews"] +
              (((newReview && rating != null) || (oldRating == null && rating != null))
                  ? 1
                  : (rating == null && oldRating != null)
                      ? -1
                      : 0),
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> createSpace(Person appUser, Space space, {List<XFile>? images}) async {
    try {
      await FirebaseFirestore.instance.collection(Collections.space).add({
        "name": space.name,
        "description": space.description,
        "address": space.address,
        "calendar": <String, List<Map<String, String>>>{},
        "contacts": space.contacts,
        "elements": space.elements,
        "location": const GeoPoint(0, 0),
        "price": space.price,
        "numberOfPeople": space.numberOfPeople,
        "owner": appUser.id,
        "totalScore": 0,
        "numberOfReviews": 0,
        "tags": space.tags,
      }).then((value) async {
        await appUser.addSpace(value.id);
        space.id = value.id;
        if (images != null) await space.addImages(images);
      });
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

  Future addImages(List<XFile> images) async {
    try {
      Future.forEach(images, (XFile image) async {
        await FirebaseStorage.instance
            .ref()
            .child("$id/${image.name}")
            .putData(await image.readAsBytes(), SettableMetadata(contentType: "image/jpeg"));
      });
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
