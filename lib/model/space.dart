import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hevento/model/filter.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/services/collections.dart';
import 'package:hevento/services/constants.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';
import 'package:hevento/services/static_functions.dart';
import 'package:hevento/widgets/custom_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class Space {
  String id;
  late String name;
  late String description;
  late String address;
  Map<DateTime, String> calendar = <DateTime, String>{};
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
  Map<int, int?> price = {
    DateTime.monday: null,
    DateTime.tuesday: null,
    DateTime.wednesday: null,
    DateTime.thursday: null,
    DateTime.friday: null,
    DateTime.saturday: null,
    DateTime.sunday: null,
  };
  late GeoPoint location;
  late int numberOfPeople;
  late Person owner;
  late double totalScore;
  late int numberOfReviews;
  late List<String>? tags;
  late Widget image;
  late String? profileImage;
  late bool hidden;

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
      price = (data["price"] as Map<String, dynamic>).map((key, value) => MapEntry(int.parse(key), value == null ? null : value as int));
      image = FutureBuilder(
          future: Functions.getImageUrl(id, data["profileImage"]),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) return loader;
            return Image.network(
              snapshot.data as String,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            );
          });
      hidden = data["hidden"];
      profileImage = data["profileImage"];
    } catch (e) {
      print(e.toString());
      return null;
    }
    return this;
  }

  bool pass(Filter filter) {
    if (filter.name != null && filter.name!.isNotEmpty && !name.toLowerCase().contains(filter.name!.toLowerCase())) return false;
    if (hidden) return false;
    if (filter.price * 1.1 < minPrice) return false;
    if ((numberOfPeople * 1.5 < filter.numberOfPeople || filter.numberOfPeople < numberOfPeople * 0.9) && filter.numberOfPeople != 0) return false;
    if (filter.music && !elements["music"]!) return false;
    if (filter.drinks && !elements["drinks"]!) return false;
    if (filter.food && !elements["food"]!) return false;
    if (filter.waiter && !elements["waiter"]!) return false;
    if (filter.security && !elements["security"]!) return false;
    if (filter.smoking && !elements["smoking"]!) return false;
    if (filter.specialEffects && !elements["specialEffects"]!) return false;
    if (filter.rating != 0 && rating != 0 && rating < filter.rating) return false;
    if (calendar.keys.any((day) => isSameDay(filter.selectedDay, day))) return false;
    if (filter.selectedDay != null && price[filter.selectedDay!.weekday] == null) return false;
    return true;
  }

  Future handleEvent(DateTime dateTime, String description, {bool remove = false}) async {
    try {
      if (remove) {
        calendar.remove(dateTime.trim());
      } else {
        calendar[dateTime.trim()] = description;
      }
      await FirebaseFirestore.instance
          .collection(Collections.space)
          .doc(id)
          .update({"calendar": calendar.map((key, value) => MapEntry(key.toString(), value))});
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateSpace({List<XFile>? images}) async {
    try {
      await FirebaseFirestore.instance.collection(Collections.space).doc(id).update({
        "name": name,
        "description": description,
        "address": address,
        "calendar": calendar.map((key, value) => MapEntry(key.toString(), value)),
        "contacts": contacts,
        "elements": elements,
        "location": location,
        "price": price.map((key, value) => MapEntry(key.toString(), value)),
        "numberOfPeople": numberOfPeople,
        "owner": owner.id,
        "totalScore": totalScore,
        "numberOfReviews": numberOfReviews,
        "tags": tags,
        "hidden": hidden,
      }).then((value) async {
        if (images != null) await addImages(images);
      });
    } catch (e) {
      print(e.toString());
    }
  }

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

  static Future<void> createSpace(Person appUser, Space space, {List<XFile>? images, String? profileImage}) async {
    try {
      await FirebaseFirestore.instance.collection(Collections.space).add({
        "name": space.name,
        "description": space.description,
        "address": space.address,
        "calendar": space.calendar.map((key, value) => MapEntry(key.toString(), value)),
        "contacts": space.contacts,
        "elements": space.elements,
        "location": space.location = const GeoPoint(0, 0),
        "price": space.price.map((key, value) => MapEntry(key.toString(), value)),
        "numberOfPeople": space.numberOfPeople,
        "owner": (space.owner = appUser).id,
        "totalScore": space.totalScore = 0,
        "numberOfReviews": space.numberOfReviews = 0,
        "tags": space.tags,
        "hidden": space.hidden = false,
        "profileImage": profileImage,
      }).then((value) async {
        space.id = value.id;
        space.image = CustomNetworkImage(spaceId: space.id, imageName: profileImage);
        if (images != null) await space.addImages(images);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Space>> getSpaces() async {
    try {
      List<Space> ret = await FirebaseFirestore.instance
          .collection(Collections.space)
          .get()
          .then((value) => value.docs.map((e) => Space(e.id).getData(e)!).toList());
      ret.shuffle();
      return ret;
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

  Future removeImage(String imageName) async {
    try {
      await FirebaseStorage.instance.ref().child("$id/$imageName").delete();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
