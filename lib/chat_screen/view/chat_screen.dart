import 'package:chat_app/auth_screen/controller/auth_controller.dart';
import 'package:chat_app/chat_screen/view/widgets/messages.dart';
import 'package:chat_app/chat_screen/view/widgets/new_message.dart';
import 'package:chat_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButton(
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                items: [
                  DropdownMenuItem(
                    alignment: Alignment.center,
                    value: 'Logout',
                    child: Row(
                      children: [
                        const Icon(Icons.exit_to_app),
                        SizedBox(
                          width: getWidth(10),
                        ),
                        const Text(
                          'Logout',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
                onChanged: (itemValue) {
                  if (itemValue == 'Logout') {
                    FirebaseAuth.instance.signOut();
                    controller.isLoading = false;
                  }
                }),
          )
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),

    );
  }
}
