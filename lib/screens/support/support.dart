import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 210, 88, 1),
        title: Text("Help & support"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 8,),
                Container(
                width: 350,
                child: Center(
                  child: Text("If you faced or encountered any problem or have any inquires, please don't be hesitated to contact with us by call on 0125326365 or send us an email on instafix@org.com"),
                ),
              ),
              ],
            ),

              SizedBox(height: 20,),
              Text("Thank you for using InstaFix"),
            ],
          
        ),
      ),
    );
  }
}