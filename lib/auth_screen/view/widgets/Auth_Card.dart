import 'package:chat_app/auth_screen/controller/auth_controller.dart';
import 'package:chat_app/auth_screen/view/widgets/image_picker.dart';
import 'package:chat_app/auth_screen/view/widgets/text_form_item.dart';
import 'package:chat_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<AuthController>(
              builder: (_, controller, child) => Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    if (!controller.isLogin)
                      ImagePickerUi(
                        imageFile: controller.pickedImage,
                        getImage: controller.getPickedImage,
                      ),
                    if (!controller.isLogin)
                      TextFFItem(
                        keyName: 'UserName',
                        labelText: 'UserName',
                        prefixIcon: Icons.account_circle,
                        validator: (v) => controller.validateUserName(v),
                        onSaved: (v) => controller.saveUserName(v),
                      ),
                    SizedBox(
                      height: getHeight(10),
                    ),
                    TextFFItem(
                      keyName: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      validator: (v) => controller.validateEmail(v),
                      onSaved: (v) => controller.saveEmail(v),
                    ),
                    SizedBox(
                      height: getHeight(10),
                    ),
                    TextFFItem(
                      keyName: 'password',
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      validator: (v) => controller.validatePassword(v),
                      onSaved: (v) => controller.savePassword(v),
                      suffixIcon: Icons.remove_red_eye,
                      onTapSuffixIcon: controller.switchScurePassword,
                      obscureText: controller.passwordScure,
                    ),
                    SizedBox(
                      height: getHeight(15),
                    ),
                    if (controller.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!controller.isLoading)
                      ElevatedButton(
                        onPressed: () => controller.trySubmit(context),
                        style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 30)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  25,
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primary,
                            )),
                        child: Text(
                          controller.isLogin ? 'Login' : 'Signup',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (!controller.isLoading)
                      TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.transparent,
                          ),
                          elevation: MaterialStatePropertyAll(0),
                          overlayColor: MaterialStatePropertyAll(
                            Colors.transparent,
                          ),
                        ),
                        onPressed: controller.switchLogin,
                        child: Text(
                          controller.isLogin
                              ? 'Create a new account'
                              : 'Already have an account',
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
