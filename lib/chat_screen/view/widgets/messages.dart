import 'package:chat_app/chat_screen/controller/chat_controller.dart';
import 'package:chat_app/chat_screen/view/widgets/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ChatController>(context, listen: false);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) => MessageCard(
            image: snapshot.data?.docs[index]['userImage'],
            userName: snapshot.data?.docs[index]['userName'],
            message: snapshot.data?.docs[index]['text'],
            isMe: snapshot.data?.docs[index]['userId'] == controller.user?.uid,
            keyV: ValueKey(
              snapshot.data?.docs[index].id,
            ),
          ),
          itemCount: snapshot.data?.docs.length,
        );
      },
    );
  }
}
