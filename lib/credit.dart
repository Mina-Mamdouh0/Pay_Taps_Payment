import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:payment_m/const.dart';

class PayWithCreditCard extends StatefulWidget {
  @override
  _PayWithCreditCardState createState() => _PayWithCreditCardState();
}

class _PayWithCreditCardState extends State<PayWithCreditCard> {

  final TextEditingController price=TextEditingController();

  @override
  Widget build(BuildContext context) {

    var configuration = PaymentSdkConfigurationDetails(
        profileId: Constant.profileId,
        serverKey: Constant.serverKey,
        clientKey: Constant.clientKey,
        merchantName: "merchant name",
        screentTitle: "Pay with Card",
        billingDetails: Constant.billingDetails,
        showShippingInfo: false,
        showBillingInfo: false,
        locale: PaymentSdkLocale.EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
        amount: double.tryParse(price.text)??0*10,
        currencyCode: "EGP",
        merchantCountryCode: "eg");

    var theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    configuration.iOSThemeConfigurations = theme;
    configuration.showBillingInfo = true;


    return Scaffold(
      appBar: AppBar(
        title: Row(
          children:const [
            Icon(Icons.credit_card),
            SizedBox(width: 10),
            Text("Pay With Credit Card"),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: price,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Enter Price",
                ),
              ),

              const SizedBox(height: 10,),
              Image.asset('assets/credit.jpg'),
              const SizedBox(height: 10,),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if(price.text.isNotEmpty){
                      FlutterPaytabsBridge.startCardPayment(configuration, (event) {
                        setState(() {
                          if (event["status"] == "success") {
                            var transactionDetails = event["data"];
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Payment Completed'),
                              backgroundColor:Colors.teal,
                            ));

                            if (transactionDetails["isSuccess"]) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Payment Completed'),
                                backgroundColor:Colors.teal,
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Payment Failed'),
                                backgroundColor:Colors.teal,
                              ));
                            }
                          }
                          else if (event["status"] == "error") {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Payment Failed'),
                              backgroundColor:Colors.teal,
                            ));
                          } else if (event["status"] == "event") {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Payment Failed'),
                              backgroundColor:Colors.teal,
                            ));
                          }
                        });
                      });
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please Enter Price'),
                        backgroundColor:Colors.teal,
                      ));

                    }
                  },
                  icon: const Icon(Icons.attach_money),
                  label: const Text("Pay"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
