import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
const String commColl = 'ap-dev-comments';

Future<List> getAllComments() async {
  List<Map<String, dynamic>> comments = [];
  await db.collection(commColl).get().then((event) {
    for (var doc in event.docs) {
      print('${doc.id} => ${doc.data()}');
      comments.add(doc.data());
    }
  });
  return comments;
}

Future writeComment(Map<String, dynamic> data) async {
  return await db
      .collection(commColl)
      .add(data)
      .then((documentSnapshot) =>
          print('Added Data with ID: ${documentSnapshot.id}'))
      .onError((error, stackTrace) => print(error));
}

Future updateComment(String content, String id) async {
  return await db
      .collection(commColl)
      .doc(id)
      .update({'content': content})
      .then((value) => print('Updated Data with ID: $id'))
      .onError((error, stackTrace) => print(error));
}

Future deleteComment(String id) async {
  return await db
      .collection(commColl)
      .doc(id)
      .delete()
      .then((value) => print('Deleted Data with ID: $id'))
      .onError((error, stackTrace) => print(error));
}
