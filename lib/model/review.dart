import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/model/person.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/collections.dart';

class Review {
  late String? id;
  String personId;
  String spaceId;
  String? content;
  int? rating;

  Review({this.id, required this.personId, required this.spaceId, required this.content, required this.rating});

  static Future<Review?> getReview(String personId, String spaceId) async {
    return await FirebaseFirestore.instance
        .collection(Collections.review)
        .where("personId", isEqualTo: personId)
        .where("spaceId", isEqualTo: spaceId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) return null;
      Review ret = Review(
        id: value.docs.first.id,
        personId: value.docs.first["personId"],
        spaceId: value.docs.first["spaceId"],
        content: value.docs.first["content"],
        rating: value.docs.first["rating"],
      );
      return ret;
    });
  }

  static Future createReview(Person appUser, Space space, String? content, int? rating) async {
    return await FirebaseFirestore.instance
        .collection(Collections.review)
        .where("personId", isEqualTo: appUser.id)
        .where("spaceId", isEqualTo: space.id)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance.collection(Collections.review).doc(value.docs.isEmpty ? null : value.docs.first.id).set({
        "spaceId": space.id,
        "personId": appUser.id,
        "content": content,
        "rating": rating,
      }).then((_) async {
        await space.addReview(
          rating,
          oldRating: value.docs.isEmpty ? null : value.docs.first["rating"],
          newReview: value.docs.isEmpty,
        );
      });
    });
  }
}
