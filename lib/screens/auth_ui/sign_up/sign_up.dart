// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:carservicesapp/screens/auth_ui/login/login.dart';
import 'package:carservicesapp/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:carservicesapp/widgets/primary_button/primary_button.dart';
import 'package:carservicesapp/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  subTitle: " Welcome back to InstaFix",
                  title: " Create account"),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Phone",
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Password",
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
                        isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color.fromARGB(255, 210, 88, 1),
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                title: "Create an account",
                onPressed: () async {
                 bool isValidated = signUpValidation(email.text, password.text, name.text,phone.text);
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .signUp(name.text, email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance.pushAndRemmoveUntil(
                          widget: const CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(child: Text("I have already an account?")),
              Center(
                child: CupertinoButton(
                    onPressed: () {
                      Routes.instance.push(widget: Login(), context: context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
