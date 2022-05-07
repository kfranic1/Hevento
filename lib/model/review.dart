import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/collections.dart';
import 'package:hevento/services/extensions/datetime_extension.dart';

class Review {
  late String? id;
  String personId;
  String spaceId;
  String? content;
  int? rating;
  DateTime time;

  Review({this.id, required this.personId, required this.spaceId, required this.content, required this.rating, required this.time});

  static Future<Review?> getReview({required String personId, required String spaceId}) async {
    return await FirebaseFirestore.instance
        .collection(Collections.review)
        .where("personId", isEqualTo: personId)
        .where("spaceId", isEqualTo: spaceId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) return null;
      return parseToReview(value.docs.first);
    });
  }

  Future createReview(Space space) async {
    return await FirebaseFirestore.instance
        .collection(Collections.review)
        .where("personId", isEqualTo: personId)
        .where("spaceId", isEqualTo: spaceId)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance.collection(Collections.review).doc(value.docs.isEmpty ? null : value.docs.first.id).set({
        "spaceId": spaceId,
        "personId": personId,
        "content": content,
        "rating": rating,
        "time": DateTime.now().trim(),
      }).then((_) async {
        await space.addReview(
          rating,
          oldRating: value.docs.isEmpty ? null : value.docs.first["rating"],
          newReview: value.docs.isEmpty,
        );
      });
    });
  }

  static Review parseToReview(DocumentSnapshot data){
    Review ret = Review(
        id: data.id,
        personId: data["personId"],
        spaceId: data["spaceId"],
        content: data["content"],
        rating: data["rating"],
        time: (data["time"] as Timestamp).toDate(),
      );
      return ret;
  }
}
