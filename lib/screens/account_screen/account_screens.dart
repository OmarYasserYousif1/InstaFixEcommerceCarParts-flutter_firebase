// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:carservicesapp/screens/about_us/about_us.dart';
import 'package:carservicesapp/screens/auth_ui/Welcome/Welcome.dart';
import 'package:carservicesapp/screens/change_password/change_password.dart';
import 'package:carservicesapp/screens/edit_profile/edit_profile.dart';
import 'package:carservicesapp/screens/favourites_screen/favourites_screen.dart';
import 'package:carservicesapp/screens/support/support.dart';
import 'package:carservicesapp/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
            AppProvider appProvider = Provider.of<AppProvider>(context,);

    return Scaffold(
     appBar: AppBar(toolbarHeight: 3,),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appProvider.getUserInformation!.image==null ?
                  Icon(
                    Icons.person_outline,
                    size: 100,
                  ) : CircleAvatar(
                      backgroundImage: NetworkImage(appProvider.getUserInformation!.image!),
                      backgroundColor: const Color.fromARGB(255, 210, 88, 1),
                      radius: 50,
                    ),
                  Text(
                   appProvider.getUserInformation!.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    appProvider.getUserInformation!.email,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      width: 118,
                      child: PrimaryButton(
                        title: "Edit profile",
                        onPressed: () {
                          Routes.instance.push(widget: EditProfile(), context: context);
                        },
                      ),),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                 /*  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.shopping_bag_outlined),
                    title: Text("Your orders"),
                  ), */
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: const FavouritesScreen(), context: context);
                    },
                    leading: Icon(Icons.favorite_outline),
                    title: Text("Favourites"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: AboutUs(), context: context);
                    },
                    leading: Icon(Icons.info_outline),
                    title: Text("About us"),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(widget: SupportScreen(), context: context);
                    },
                    leading: Icon(Icons.support_outlined),
                    title: Text("Support"),
                  ),
                   ListTile(
                    onTap: () {
                      Routes.instance.push(widget: ChangePassword(), context: context);
                    },
                    leading: Icon(Icons.change_circle_outlined),
                    title: Text("Change password"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      //Routes.instance.push(widget: Welcome(), context: context);
                      setState(() {});
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Log out"),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text("Version 1.0.0"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
