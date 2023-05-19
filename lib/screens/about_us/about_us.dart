import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 210, 88, 1),
        title: Text("About us"),
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
                  child: Text("Welcome to our car services app! We are a team of passionate individuals who believe that every car owner deserves a hassle-free and convenient way to take care of their vehicles. Our app is designed to make car maintenance and repair as simple and stress-free as possible. We understand that finding a reliable mechanic, scheduling appointments, and keeping track of maintenance records can be a frustrating and time-consuming process. That's why we created our app to streamline the entire process and provide you with a one-stop-shop for all your car needs. Our team is made up of experienced professionals who are dedicated to providing the best possible service to our customers. We have partnered with top-rated mechanics and service centers to ensure that you receive the highest quality of workmanship and customer service. Whether you need a routine oil change, a major repair, or just some advice on how to keep your car running smoothly, our app has you covered. With our easy-to-use interface, you can schedule appointments, track your maintenance history, and get personalized recommendations for your specific make and model. We are committed to making car ownership a more enjoyable and stress-free experience for our customers. Thank you for choosing our car services app, and we look forward to serving you!"),
                ),
              ),],
            ),
          ],
        ),
      ),
    );
  }
}
