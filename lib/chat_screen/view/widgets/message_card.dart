import 'package:chat_app/size_config.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final String image;
  final bool isMe;
  final Key keyV;
  final String userName;

  const MessageCard({
    Key? key,
    required this.image,
    required this.keyV,
    required this.userName,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*UnconstrainedBox(
      alignment:isMe? Alignment.centerRight:Alignment.centerLeft,*/
        Stack(
        clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                UnconstrainedBox(
                  child: Container(
                    // width: getWidth(170),
                    constraints: BoxConstraints.tightForFinite(
                      width: getWidth(170),
                    ),
                    margin: const EdgeInsets.only(top: 18),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(15),
                          bottomRight: const Radius.circular(15),
                          topRight: isMe
                              ? const Radius.circular(0)
                              : const Radius.circular(15),
                          topLeft: isMe
                              ? const Radius.circular(15)
                              : const Radius.circular(0)),
                      color: isMe
                          ? Colors.grey[600]
                          : Theme.of(context).colorScheme.secondary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(color: Colors.white),
                          textAlign: isMe ? TextAlign.right : TextAlign.left,
                        ),
                        Text(
                          message,
                          style: const TextStyle(color: Colors.white),
                          textAlign: !isMe ? TextAlign.right : TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(10),
            )
          ],
        ),
        Positioned(
          top: 0,
            left: isMe? 0:-10,
            right: isMe?-10:0,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: getWidth(40),
              height: getHeight(40),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
          child:Image.network(image,fit: BoxFit.contain,width: 40,height: 40,)
        ))

      ],
    );
    /* child:
    );*/
  }
}
