// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
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
                            FittedBox(
                              child: Text(
                                widget.singleProduct.name,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (qty > 1) {
                                      setState(() {
                                        qty--;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: CircleAvatar(
                                    maxRadius: 13,
                                    backgroundColor:
                                        const Color.fromARGB(255, 210, 88, 1),
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  qty.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      qty++;
                                    });
                                    appProvider.updateQty(
                                        widget.singleProduct, qty);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: CircleAvatar(
                                    maxRadius: 13,
                                    backgroundColor:
                                        const Color.fromARGB(255, 210, 88, 1),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (!appProvider.getFavouriteProductList
                                    .contains(widget.singleProduct)) {
                                  appProvider.addFavouriteProduct(
                                      widget.singleProduct);
                                  showMessage("Added to wishlist");
                                } else {
                                  appProvider.removeFavouriteProduct(
                                      widget.singleProduct);
                                  showMessage("Removed from wishlist");
                                }
                              },
                              child: Text(
                                appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)
                                    ? "Removed"
                                    : "Add to wishlist",
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
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        appProvider.removeCartProduct(widget.singleProduct);
                        showMessage("Removed from Cart");
                      },
                      child: CircleAvatar(
                        maxRadius: 13,
                        child: Icon(
                          Icons.delete,
                          size: 18,
                        ),
                        backgroundColor: const Color.fromARGB(255, 210, 88, 1),
                      ),
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
