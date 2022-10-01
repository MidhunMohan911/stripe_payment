import 'dart:convert';

import 'package:dckap_shopping/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
              // applePay: const PaymentSheetApplePay(merchantCountryCode: "+92"),
              googlePay: const PaymentSheetGooglePay(
                  testEnv: true,
                  currencyCode: "IN",
                  merchantCountryCode: "+91"),
              merchantDisplayName: 'Prospects',
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              // customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ))
            .then((value) {});
        displayPaymentSheet();
        print(paymentIntentData);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    CartController cartController = Get.find<CartController>();
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));

      paymentIntentData = null;

      cartController.cartProducts = [];
      cartController.update();
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LnOakSEwUNAalaJj8QsPRvN2l4nWwbgPcg4MsVuGG2BPEnGqcoTft580uI8GqmFPTaxIjDxV3IqqYtcdn3iKqGe00VeFtZj4m',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(response.body);
      return jsonDecode(response.body.toString());
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
