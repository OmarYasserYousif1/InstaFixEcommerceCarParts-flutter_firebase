// ignore_for_file: prefer_const_constructors

import 'package:carservicesapp/provider/app_provider.dart';
import 'package:carservicesapp/screens/favourites_screen/widgets/single_favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 210, 88, 1),
        title: const Text("Favourites screen"),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(
              child: Text("Empty "),
            )
          : ListView.builder(
              itemCount: appProvider.getFavouriteProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              }),
    );
  }
}
