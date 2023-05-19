import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  final String title, subTitle;
  const TopTitles({super.key, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kToolbarHeight-30,
        ),
        if (title == " Login" || title == " Create account")
          GestureDetector(child: const Icon(Icons.arrow_back), onTap: () {
            Navigator.of(context).pop();
          },),
          const SizedBox(height: 15,),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}
