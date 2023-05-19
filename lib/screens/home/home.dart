// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:carservicesapp/constants/routes.dart';
import 'package:carservicesapp/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:carservicesapp/models/category_model/caregory_model.dart';
import 'package:carservicesapp/models/product_model/product_model.dart';
import 'package:carservicesapp/provider/app_provider.dart';
import 'package:carservicesapp/screens/category_view/category_view.dart';
import 'package:carservicesapp/screens/product_details/product_details.dart';
import 'package:carservicesapp/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestSelling();
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
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
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: TopTitles(subTitle: "", title: "InstaFix")),
                       /*  TextFormField(
                          decoration: InputDecoration(hintText: "Search...."),
                        ), */
                        /* SizedBox(
                          height: 24,
                        ), */
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? Center(
                          child: Text("empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget:
                                                CategoryView(categoryModel: e),
                                            context: context);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 8.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: Text(
                                            e.name,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(e.image),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Best selling",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  productModelList.isEmpty
                      ? Center(
                          child: Text("Empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 50),
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
