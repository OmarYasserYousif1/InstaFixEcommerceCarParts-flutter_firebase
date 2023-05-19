// ignore_for_file: use_build_context_synchronously

import 'package:carservicesapp/models/order_model/order_model.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carservicesapp/constants/constants.dart';
import 'package:carservicesapp/models/category_model/caregory_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestSelling() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context, String payment) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Orders")
          .doc();
      DocumentReference admin = _firebaseFirestore.collection("Orders").doc();
      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "pending",
        "toralPrice": totalPrice,
        "payment": payment,
        "orderId":admin.id,
      });

      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "pending",
        "toralPrice": totalPrice,
        "payment": payment,
        "orderId":documentReference.id,
      });
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Ordered Successfully");
      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  /// Get order user

  Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("usersOrders")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Orders")
              .get();

      List<OrderModel> orderList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();
      return orderList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
  
}
