import 'package:carservicesapp/constants/theme.dart';
import 'package:carservicesapp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:carservicesapp/firebase_helper/firebase_options/firebase_options.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:carservicesapp/screens/auth_ui/Welcome/Welcome.dart';
import 'package:carservicesapp/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.paltformOptions,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insta Fix',
        theme: themeData,
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const CustomBottomBar();
              }
              return const Welcome();
            }),
      ),
    );
  }
}
