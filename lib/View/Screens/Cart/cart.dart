
import 'package:dckap_shopping/Model/cart_model.dart';
import 'package:dckap_shopping/View/Constants/constants.dart';
import 'package:dckap_shopping/controller/controller.dart';


import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controller/payment_controller.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    final PaymentController payController = Get.put(PaymentController());
    CartController cartController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: kblack,
      bottomSheet: Container(
        height: 60,
        color: Colors.black87,
        child: GetBuilder<CartController>(initState: (state) {
          cartController.getTotalSum();
        }, builder: (controller) {
          int? totalPrice = controller.totalPrice;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // GetBuilder<CartController>(initState: (state) {
              //   cartController.getTotalSum();
              // }, builder: (controller) {
              // int? totalPrice = controller.totalPrice;
              //  return
              Text(
                '$totalPrice /-',
                style: TextStyle(
                    fontSize: 20, color: kWhite, fontWeight: FontWeight.w600),
              ),
              // }),
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      payController.makePayment(
                          amount: controller.totalPrice.toString(),
                          currency: 'INR');

                      
                    },
                    child: const Text('Place order'));
              }),
            ],
          );
        }),
      ),
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(builder: (controller) {
        List<CartModelProduct> products = controller.cartProducts;

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            CartModelProduct product = products[index];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.asset(
                  product.image,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  product.name,
                  style: TextStyle(color: kWhite),
                ),
                subtitle: Text(
                  "${product.price} x ${product.quantity}",
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // controller.decrement();
                        controller.incrementOrDecrement(
                          context,
                          index: index,
                          isIncrement: false,
                        );
                      },
                      icon: Icon(
                        Icons.remove,
                        color: kWhite,
                      ),
                    ),
                    Text(
                      product.quantity.toString(),
                      style: TextStyle(color: kWhite),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.incrementOrDecrement(context,
                            index: index, isIncrement: true);
                      },
                      icon: Icon(
                        Icons.add,
                        color: kWhite,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
