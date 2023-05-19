// ignore_for_file: prefer_const_constructors

import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:carservicesapp/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:carservicesapp/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  final ProductModel singleProduct;
  const CheckOut({super.key, required this.singleProduct});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 210, 88, 1),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 210, 88, 1),
                      width: 2.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Cash on delivery",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextFormField(
              controller: address,
              decoration: const InputDecoration(
                hintText: "Address",
                prefixIcon: Icon(
                  Icons.location_city,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: phone,
              decoration: const InputDecoration(
                hintText: "Phone number",
                prefixIcon: Icon(
                  Icons.phone,
                ),
              ),
            ),
            /* Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 210, 88, 1),
                      width: 2.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.credit_card),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Pay online",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ), */
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Continue",
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProduct(widget.singleProduct);

                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderedProductFirebase(appProvider.getBuyProductList,
                        context, groupValue == 1 ? "Cash on delivery" : "Paid");
                if (value) {
                  Future.delayed(Duration(seconds: 2), () {
                    Routes.instance
                        .push(widget: CustomBottomBar(), context: context);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
