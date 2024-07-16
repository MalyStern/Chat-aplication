import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String reciveID;
  final String message;
  final Timestamp timestamp;
  final bool isRead;
  Message({
    required this.senderID,
    required this.senderEmail,
    required this.reciveID,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'reciveID': reciveID,
      'message': message,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      senderID: map['senderID'],
      senderEmail: map['senderEmail'],
      reciveID: map['reciveID'],
      message: map['message'],
      timestamp: map['timestamp'],
      isRead: map['isRead'],
    );
  }
}

class Users {
  String userID;
  String email;
  bool hasUnreadMessage;

  Users({
    required this.userID,
    required this.email,
    this.hasUnreadMessage = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'hasUnreadMessage': hasUnreadMessage,
    };
  }

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      userID: map['userID'],
      email: map['email'],
      hasUnreadMessage: map['hasUnreadMessage'] ?? false,
    );
  }
}
