// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'dart:io';

import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:carservicesapp/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  ////Cart work
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];
  UserModel? _userModel;
  UserModel? get getUserInformation => _userModel;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

////Favourite
  List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  ////User Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
   // showLoaderDialog(context);
    if (file == null) {
      showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context,rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      notifyListeners();
     Navigator.of(context,rootNavigator: true).pop();
     Navigator.of(context).pop();
    }
          showMessage("Profile updated successfully");

    notifyListeners();
  }
  ////Total price
  double totalPrice () {
    double totalPrice = 0.0;
    for (var element in _cartProductList){
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

/// Update quantity
  void updateQty (ProductModel productModel, int qty){
   int index = _cartProductList.indexOf(productModel);
  _cartProductList [index].qty=qty;
  notifyListeners();
  }

/// Buy product
void addBuyProduct(ProductModel model) {
_buyProductList.add(model);
notifyListeners();
}


void addBuyProductCartList() {
_buyProductList.addAll(_cartProductList);
notifyListeners();
}

void clearCart() {
_cartProductList.clear();
notifyListeners();
}

void clearBuyProduct() {
_buyProductList.clear();
notifyListeners();
}

List <ProductModel> get getBuyProductList => _buyProductList;
}
