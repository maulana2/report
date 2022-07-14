import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'dart:io';

class AktivitasKuController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

 Stream<QuerySnapshot<Map<String, dynamic>>> aktivitasKu() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection("Sales")
        .doc(uid)
        .collection("report")
        .orderBy("date", descending: true)
        .snapshots();
    
  }
}
