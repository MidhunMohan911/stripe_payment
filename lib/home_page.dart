import 'package:badges/badges.dart';
import 'package:dckap_shopping/Model/cart_model.dart';
import 'package:dckap_shopping/Model/products.dart';
import 'package:dckap_shopping/View/Constants/constants.dart';
import 'package:dckap_shopping/View/Screens/Cart/cart.dart';
import 'package:dckap_shopping/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';

import 'View/Screens/Widget/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<Product> products = [
    Product(
        price: 1000,
        name: "Men overcoat",
        image:
            "assets/HD-wallpaper-zayn-malik-2018-vogue-hoot-red-costume-superstars-british-singer-hollywood-malik-guys.jpg"),
    Product(
        price: 1000,
        name: "Iphone 14 pro",
        image: "assets/iPhone-14-Pro-Max-Space-Black.jpg"),
    Product(price: 1000, name: "Product ", image: "assets/download.jpeg"),
    Product(
        price: 1000,
        name: "jjkkj ",
        image:
            "assets/b6e22b58-3450-468f-afeb-3218b6ce7acb1602737925709SareemallNavyBluePolyChiffonSolidEthnicPartywearSareewithMat1.webp"),
    Product(
        price: 1000,
        name: "Product ",
        image:
            "assets/021567ee-4b64-4a56-9abc-a9465d61f5981658139345853-Nike-Air-Max-270-G-Golf-Shoe-3631658139345557-1.webp"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: const Text('Shop Island'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            icon: GetBuilder<CartController>(
              init: CartController(),
              builder: (controller) {

              return Badge(
                badgeColor: Colors.white,
                badgeContent: Text(
                  controller.cartProducts.length.toString(),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                ),
              );
            }),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 280,
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0),
        itemBuilder: (context, index) {
          Product product = products[index];

          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      product.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    GetBuilder<CartController>(
                        init: CartController(),
                        builder: (controller) {
                          bool isAdded = controller.cartProducts
                              .any((element) => element.name == product.name);

                          return IconButton(
                              onPressed: () {
                                controller.addToCart(
                                  CartModelProduct(
                                    image: product.image,
                                    name: product.name,
                                    price: product.price,
                                    quantity: 1,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: isAdded ? Colors.grey : Colors.black,
                              ));
                        }),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    product.name + "$index",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text('${product.price} /-'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
