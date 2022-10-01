import 'package:dckap_shopping/Model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var item = 0.obs;
  List<CartModelProduct> cartProducts = [];
  int totalPrice = 0;

  // increment() {
  //   item.value++;
  // }

  int? getTotalSum() {
    // looping over data array
    for (var item in cartProducts) {
      //getting the key direectly from the name of the key
      totalPrice += item.price;
      print(1);
    }
    print("total Price");
    print(totalPrice);
    return totalPrice;
  }

  incrementOrDecrement(BuildContext context,
      {required int index, required bool isIncrement}) {
    int availableQuantity = cartProducts[index].quantity;

    if (availableQuantity == 1 && !isIncrement) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Confirmation."),
            content: const Text("Are you sure ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cartProducts.removeAt(index);
                    totalPrice = totalPrice - cartProducts[index].price;
                    update();
                  },
                  child: const Text("Yes"))
            ],
          );
        },
      );

      return;
    }

    if (isIncrement) {
      cartProducts[index].quantity = availableQuantity + 1;
      totalPrice = totalPrice + cartProducts[index].price;
    } else {
      cartProducts[index].quantity = availableQuantity - 1;
      totalPrice = totalPrice - cartProducts[index].price;
    }
    update();
  }

  addToCart(CartModelProduct cartModelProduct) {
    bool isAlreadyAdded =
        cartProducts.any((element) => element.name == cartModelProduct.name);
    if (isAlreadyAdded) {
      int index = cartProducts
          .indexWhere((element) => element.name == cartModelProduct.name);

      cartProducts.removeAt(index);
      print(cartProducts);
    } else {
      cartProducts.add(cartModelProduct);
    }
    update();
    print(cartProducts);
  }
}
