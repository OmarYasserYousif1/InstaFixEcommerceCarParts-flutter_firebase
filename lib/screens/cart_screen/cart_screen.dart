// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:carservicesapp/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:carservicesapp/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:carservicesapp/screens/checkout/checkout.dart';
import 'package:carservicesapp/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              PrimaryButton(
                title: "Checkout",
                onPressed: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  if (appProvider.getBuyProductList.isEmpty) {
                    showMessage("Cart is empty");
                  }else{
                  Routes.instance.push(widget: CartItemCheckout(), context: context);
                }},
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 210, 88, 1),
        title: const Text("Cart Screen"),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? Center(child: Text("Empty"))
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              }),
    );
  }
}
