// ignore_for_file: file_names

import 'package:carservicesapp/constants/assets_images.dart';
import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/screens/auth_ui/login/login.dart';
import 'package:carservicesapp/screens/auth_ui/sign_up/sign_up.dart';
import 'package:carservicesapp/widgets/primary_button/primary_button.dart';
import 'package:carservicesapp/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(
                subTitle: "Buy your car parts while sitting in your home",
                title: "Welcome"),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Image.asset(
                AssetsImages.instance.logoImage,
                alignment: Alignment.center,
                height: 200,
              ),
            ),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.facebook,
                    size: 36,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    AssetsImages.instance.googleLogo,
                    scale: 30.0,
                  ),
                ),
              ],
            ), */
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () {
                Routes.instance.push(widget: const Login(), context: context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              title: "Sign Up",
              onPressed: () {
                Routes.instance.push(widget: const SignUp(), context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
