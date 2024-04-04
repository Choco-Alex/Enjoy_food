import 'package:enjoy_food/components/my_button.dart';
import 'package:enjoy_food/pages/deliveryProgressPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // user want to pay
  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      // only show dialog if form is valid
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Confirm payment"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text("Card Number : $cardNumber"),
                      Text("Expiry Date : $expiryDate"),
                      Text("Card Holder Name : $cardHolderName"),
                      Text("CVV : $cvvCode"),
                    ],
                  ),
                ),
                actions: [
                  // cancel button
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),

                  // yes button
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryProgressPage()));
                      },
                      child: const Text("Yes"))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          // credit card
          CreditCardWidget(
            cardBgColor: Colors.red,
            height: 200,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            onCreditCardWidgetChange: (p0) {},
          ),
          // credit card form
          CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });
              },
              formKey: formKey),

          const Spacer(),

          MyButton(
            text: "Pay now",
            onTap: () {
              userTappedPay();
            },
          ),
        ],
      ),
    );
  }
}
