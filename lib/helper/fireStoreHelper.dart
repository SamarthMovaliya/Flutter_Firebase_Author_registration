import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseStoreHelper {
  FireBaseStoreHelper._();

  static final FireBaseStoreHelper fireBaseStoreHelper =
      FireBaseStoreHelper._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insert({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection('counter').doc('CounterKeeper').get();
    int id = k['id'];
    int len = k['lenght'];
    await db.collection("Authors").doc("${++id}").set(data);
    db.collection("Authors").doc("$id").update({"id": id});
    db
        .collection("counter")
        .doc("CounterKeeper")
        .update({'id': id, 'lenght': ++len});
  }

  Future<void> update({required Map<String, dynamic> data}) async {
    String id = data['id'].toString();
    db.collection('Authors').doc(id).set(data);
  }

  Delete({required Map<String, dynamic> data}) async {
    String id = data['id'].toString();
    await db.collection("Authors").doc(id).delete();

    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection("counter").doc("CounterKeeper").get();

    int length = k['lenght'];

    await db
        .collection("counter")
        .doc("CounterKeeper")
        .update({"lenght": --length});
  }
}
