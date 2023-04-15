import 'package:chat_app/chat_screen/controller/chat_controller.dart';
import 'package:chat_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatelessWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller= Provider.of<ChatController>(context);
    return SizedBox(
        height: getHeight(60),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Send a Message',
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey

                ),
                controller: controller.messageController,
                onChanged:(value) =>  controller.onChangedMessageField(value),
              ),
            ),
            SizedBox(
              width: getWidth(5),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5,right: 2),
              child: IconButton(
                  style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(
                        CircleBorder(),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary,
                      )),
                  onPressed: controller.messageController.text.trim().isEmpty
                      ? null
                      :()=> controller.sendMessage(context),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
            )
          ],
        ),

    );
  }
}
