import 'package:chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  final _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String reciveID, String message) async {
    final currentUser = await _auth.currentUser!;

    final newMessage = Message(
      senderEmail: currentUser.email!,
      senderID: currentUser.uid,
      reciveID: reciveID,
      message: message,
      timestamp: Timestamp.now(),
    );

    final chatRoomId = [currentUser.uid, reciveID]..sort();
    await _fireStore
        .collection('chat_room')
        .doc(chatRoomId.join('_'))
        .collection('massege')
        .add(newMessage.toMap());

    await _fireStore
        .collection("Users")
        .doc(currentUser.uid)
        .update({'hasUnreadMessage': true});


  }
      Stream<List<Users>> getUsersStream() {
      return _fireStore.collection("Users").snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Users.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      });
    }

  Future<void> markMessageAsRead(String reciveID, String senderID) async {
    final chatRoomID = [senderID, reciveID]..sort();

    final messageSnapshot = await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID.join('_'))
        .collection("messages")
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in messageSnapshot.docs) {
      await doc.reference.update({'isRead': true});
    }

    await _fireStore
        .collection("Users")
        .doc(senderID)
        .update({'hasUnreadMessage': false});
  }

  Stream<QuerySnapshot> getMessage(String userID, String otherUserID) {
    final chatRoomID = [userID, otherUserID]..sort();
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID.join('_'))
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
