import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> saveText(String userId, String text) async {
    await _firestore.collection('users').doc(userId).set({'text': text}, SetOptions(merge: true));
  }
  Future<String?> loadText(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data()?['text'];
  }
}