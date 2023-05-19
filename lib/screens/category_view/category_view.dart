// ignore_for_file: prefer_const_constructors

import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:carservicesapp/models/category_model/caregory_model.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kToolbarHeight-20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        BackButton(),
                        Text(
                          widget.categoryModel.name,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  productModelList.isEmpty
                      ? Center(
                          child: Text("Empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productModelList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  margin: EdgeInsets.all(1.0),
                                  padding: EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(132, 233, 184, 149),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        singleProduct.image,
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Text(
                                        singleProduct.name,
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text("Price: ${singleProduct.price}"),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 120,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: ProductDetails(
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 251, 167, 107),
                                            textStyle:
                                                TextStyle(color: Colors.black),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 64, 64, 64),
                                                width: 1),
                                          ),
                                          child: Text(
                                            "Buy",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );
  }
}
