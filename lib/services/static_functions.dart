import 'package:firebase_storage/firebase_storage.dart';

abstract class Functions {
  static Future<String> loadImage(String id, String imgName) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(id).child(imgName);
      var url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e.toString());
      return "https://firebasestorage.googleapis.com/v0/b/hevento-7371e.appspot.com/o/123%2FtileImage.jpg?alt=media&token=7d0a4b42-1fd1-4d6b-8c94-85f2eee3db90";
    }
  }

  static Future<List<String>> loadImages(String id) async {
    try {
      return FirebaseStorage.instance
          .ref()
          .child(id)
          .listAll()
          .then((value) async => await Future.wait(value.items.map((e) async => await e.getDownloadURL()).toList()));
    } catch (e) {
      print(e.toString());
      return [
        "https://firebasestorage.googleapis.com/v0/b/hevento-7371e.appspot.com/o/123%2FtileImage.jpg?alt=media&token=7d0a4b42-1fd1-4d6b-8c94-85f2eee3db90"
      ];
    }
  }
}