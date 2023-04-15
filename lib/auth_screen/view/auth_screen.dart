import 'package:chat_app/auth_screen/view/widgets/Auth_Card.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/size_config.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const AuthCard(),
    );
  }
}
