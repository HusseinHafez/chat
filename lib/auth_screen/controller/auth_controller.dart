import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class AuthController with ChangeNotifier {
  bool passwordScure = true;
  bool isLogin = true;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;
  final auth = FirebaseAuth.instance;

  void getPickedImage() async {
    final picker = ImagePicker();
    XFile? pickImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickImage == null) {
      return;
    }
    pickedImage = File(pickImage.path);
    notifyListeners();
  }

  void switchLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  void switchScurePassword() {
    passwordScure = !passwordScure;
    notifyListeners();
  }

  String? validateUserName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 4) {
      return 'Please enter at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Please enter at least 8 characters';
    }
    return null;
  }

  void saveUserName(String? value) {
    userNameController.text = value!;
    notifyListeners();
  }

  void saveEmail(String? value) {
    emailController.text = value!;
    notifyListeners();
  }

  void savePassword(String? value) {
    passwordController.text = value!;
    notifyListeners();
  }

  void trySubmit(BuildContext context) {
    final isValid = formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (pickedImage == null && !isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your Image'),
          backgroundColor: Colors.grey,
        ),
      );
      return;
    }
    if (!isValid!) {
      return;
    }
    formKey.currentState?.save();

    submit(
      name: userNameController.text.trim(),
      email: emailController.text.trim(),
      image: pickedImage,
      password: passwordController.text.trim(),
      ctx: context,
      isLogin: isLogin,
    );
    notifyListeners();
  }

  void submit({
    required String name,
    required String email,
    required String password,
    required bool isLogin,
    required File? image,
    required BuildContext ctx,
  }) async {
    UserCredential authResult;
    isLoading = true;
    notifyListeners();
    try {
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${authResult.user!.uid}.jpg');
        await ref.putFile(image!).whenComplete(() => null);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'imageUrl': url,
          'userName': name,
          'email': email,
        });
        notifyListeners();
      }
    } on PlatformException catch (error) {
      String message = 'An error has been occurred';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey,
      ));
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.message.toString()),
          backgroundColor: Colors.grey,
        ),
      );
      isLoading = false;
      notifyListeners();
    } catch (err) {
      print(err.toString());
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }
}
