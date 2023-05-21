import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hevento/generated/firebase_options.dart';
import 'package:hevento/model/review.dart';
import 'package:hevento/model/space.dart';
import 'package:hevento/services/collections.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Review review;

  setUp(() {
    review = Review(
      id: 'testID',
      personId: 'testPersonId',
      spaceId: 'testSpaceId',
      content: 'testContent',
      rating: 5,
      time: DateTime.now(),
    );
  });

  test('Create review in real firestore', () async {
    await Firebase.initializeApp();
    await review.createReview(Space('testSpaceId'));
    final fetchedReview = await Review.getReview(personId: 'testPersonId', spaceId: 'testSpaceId');

    expect(fetchedReview, isNotNull);

    if (fetchedReview == null) return;

    expect(fetchedReview.content, 'testContent');
    expect(fetchedReview.rating, 5);
    expect(fetchedReview.personId, 'testPersonId');
    expect(fetchedReview.spaceId, 'testSpaceId');
  });

  tearDown(() async {
    // delete the review after test
    await FirebaseFirestore.instance.collection(Collections.review).doc('testID').delete();
  });
}
