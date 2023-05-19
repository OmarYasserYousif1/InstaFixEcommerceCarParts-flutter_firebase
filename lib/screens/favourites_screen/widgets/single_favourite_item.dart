// ignore_for_file: unnecessary_import, prefer_const_constructors

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({super.key, required this.singleProduct});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          border: Border.all(
              color: const Color.fromARGB(255, 210, 88, 1), width: 3)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: const Color.fromARGB(255, 210, 88, 1),
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                AppProvider appProvider =
                                    Provider.of<AppProvider>(context,
                                        listen: false);
                                appProvider.removeFavouriteProduct(
                                    widget.singleProduct);
                                showMessage("Removed from wishlist");
                              },
                              child: Text(
                                "Remove from wishlist",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                      255,
                                      210,
                                      88,
                                      1,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${widget.singleProduct.price.toString()}",
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
