import 'package:chat_app/size_config.dart';
import 'package:flutter/material.dart';

class TextFFItem extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onTapSuffixIcon;
  final bool obscureText;
  final String? keyName;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  const TextFFItem({
    Key? key,
    required this.labelText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.obscureText = false,
    this.keyName,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          key: ValueKey(keyName),
          style: const TextStyle(
            color: Colors.black,
          ),
          onChanged:onChanged ,
          validator: validator,
          onSaved: onSaved,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
               decoration: const BoxDecoration(
                  border: BorderDirectional(
                      end: BorderSide(
                width: 2,
                color: Colors.grey,
              ))),
              child: Icon(
                prefixIcon,
                // size: 25,
                color: Colors.grey,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: onTapSuffixIcon,
              child: Icon(
                suffixIcon,
                color: Colors.grey,
              ),
            ),
          ),
          obscureText: obscureText,
          controller: controller,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 75),
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: getFont(16),
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
    /*Container(

      decoration: BoxDecoration(
        border:
            Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                border: BorderDirectional(
                    end: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.primary,
            ))),
            child: Icon(
              prefixIcon,
             // size: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: getHeight(80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      labelText,
                      style: TextStyle(
                        fontSize: getFont(15),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  TextFormField(
                    key: ValueKey(keyName),
                    style:  const TextStyle(
                      color: Colors.black,
                    ),
                    validator: validator,
                    onSaved: onSaved,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),

                      suffixIcon: suffixIcon,
                    ),
                    obscureText: obscureText,
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );*/
  }
}
