// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:carservicesapp/screens/auth_ui/sign_up/sign_up.dart';
import 'package:carservicesapp/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:carservicesapp/widgets/primary_button/primary_button.dart';
import 'package:carservicesapp/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;
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
                  subTitle: " Welcome back to InstaFix", title: " Login"),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                height: 30,
              ),
              PrimaryButton(
                title: "Login",
                onPressed: () async {
                  bool isValidated = loginValidation(email.text, password.text);
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .login(email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance.pushAndRemmoveUntil(
                          widget: const CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const Center(child: Text("Don't have an account?")),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: CupertinoButton(
                    onPressed: () {
                      Routes.instance.push(widget: SignUp(), context: context);
                    },
                    child: Text(
                      "Create an account",
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
