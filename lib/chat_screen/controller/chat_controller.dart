import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatController with ChangeNotifier {
  String messageText='';
  TextEditingController messageController = TextEditingController();
  final user=  FirebaseAuth.instance.currentUser;
     void sendMessage(BuildContext context) async{
    FocusScope.of(context).unfocus();
    final userData= await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': messageText.trim(),
      'createdAt': Timestamp.now(),
      'userId':user?.uid,
      'userName':userData['userName'],
      'userImage':userData['imageUrl']
    });
    messageController.clear();
    notifyListeners();
  }

  void onChangedMessageField(String value) {
    messageText = value;
    notifyListeners();
  }
}