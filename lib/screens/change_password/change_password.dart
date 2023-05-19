// ignore_for_file: prefer_const_constructors

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:carservicesapp/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 210, 88, 1),
        title: Text("Change password"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20,),
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Enter your new Password",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(
                    isShowPassword ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromARGB(255, 210, 88, 1),
                  )),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Confirm your new password",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
            ),
          ),
          const SizedBox(
            height: 36.0,
          ),
          PrimaryButton(
            title: "Update",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("New password is empty");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("Please confirm your password");
              }else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                showMessage("Password not match");
              }
              
            },
          ),
        ],
      ),
    );
  }
}
