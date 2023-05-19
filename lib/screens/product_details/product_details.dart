// ignore_for_file: prefer_const_constructors

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:carservicesapp/screens/checkout/checkout.dart';
import 'package:carservicesapp/screens/cart_screen/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: CartScreen(), context: context);
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 300,
                width: 350,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(appProvider.getFavouriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ],
              ),
              Text(widget.singleProduct.description),
              SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 210, 88, 1),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 210, 88, 1),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      showMessage("Added");
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  SizedBox(
                    height: 37,
                    width: 145,
                    child: ElevatedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        Routes.instance.push(
                            widget: CheckOut(
                              singleProduct: productModel,
                            ),
                            context: context);
                      },
                      child: Text("BUY/RSERVE"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
