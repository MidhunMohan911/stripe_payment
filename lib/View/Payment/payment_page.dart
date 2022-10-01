import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../controller/payment_controller.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Pay with a Credit Card'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            'Card Form',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 20),
          CardFormField(
            controller: CardFormEditController(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                controller.makePayment(amount: '5', currency: 'USD');
              },
              child: const Text('Pay'))
        ],
      ),
    );
  }
}
