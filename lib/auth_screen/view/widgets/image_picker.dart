import 'dart:io';
import 'package:flutter/material.dart';
class ImagePickerUi extends StatelessWidget {
  final File? imageFile;
  final Function() getImage;
  const ImagePickerUi({
    Key? key,
    required this.imageFile,
    required this.getImage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

         CircleAvatar(
          radius: 40,
          foregroundImage: imageFile != null
              ? FileImage(imageFile!)
              :  null,
          backgroundImage: const AssetImage('assets/images/profileAccount.png'),
        ),

        ElevatedButton.icon(
          onPressed: getImage,
          icon: const Icon(Icons.image),
          label: const Text('PickImage'),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            elevation: MaterialStatePropertyAll(0),
          ),
        )
      ],
    );
  }
}
